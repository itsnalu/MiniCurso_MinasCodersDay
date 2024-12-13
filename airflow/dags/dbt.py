from airflow.decorators import dag, task, task_group
from airflow.models import Variable
from pendulum import datetime


dbt_folder = "/opt/airflow/dbt"
dbt_compressed_folder = "/opt/airflow/dbt_compressed"
dbt_profiles = f"{dbt_folder}/profiles"

def create_dag(dag_id, schedule, config, default_args):
    @dag(dag_id=dag_id, schedule=schedule, default_args=default_args, catchup=False, tags=["dbt"])
    def dbt_dag():
        @task()
        def start(*args):
            print("Starting dbt DAG")

        @task()
        def end(*args):
            print("End dbt DAG")

        @task_group(group_id='extract_code')
        def extract_code():
            @task.bash
            def clean_old_code():
                return f"rm -rf {dbt_folder}/dbt_{config.get('name')}"

            @task.bash
            def extract_new_code():
                return f"unzip -o {dbt_compressed_folder}/dbt_{config.get('name')} -d {dbt_folder}"

            clean_old_code() >> extract_new_code()

        @task_group(group_id='dbt')
        def dbt():
            project_folder = f"{dbt_folder}/dbt_{config.get('name')}" 

            @task.bash
            def dbt_seed():
                return f"cd {project_folder}; dbt seed --profiles-dir {dbt_profiles}"

            @task.bash
            def dbt_run():
                return f"cd {project_folder}; dbt run --profiles-dir {dbt_profiles}"

            @task.bash
            def dbt_test():
                return f"cd {project_folder}; dbt test --profiles-dir {dbt_profiles}"

            dbt_seed() >> dbt_run() >> dbt_test()

        start() >> extract_code() >> dbt() >> end()

    return dbt_dag()


dags = Variable.get("dbt_dags", deserialize_json=True)

for dag_ in dags:
    dag_id = "dbt_{}".format(str(dag_.get("name")))
    default_args = {"owner": "analytics", "start_date": datetime(2023, 7, 1)}
    schedule = dag_.get("schedule", "@daily")
    globals()[dag_id] = create_dag(dag_id, schedule, dag_, default_args)
