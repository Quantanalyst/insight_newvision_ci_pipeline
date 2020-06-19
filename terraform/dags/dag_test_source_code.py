import datetime as dt

import airflow
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator
from airflow.operators.email_operator import EmailOperator



def test_runtime():
    print('Recording test time')
    with open('/home/ubuntu/test_runtime.txt', 'a+', encoding='utf8') as f:
        now = dt.datetime.now()
        t = now.strftime("%Y-%m-%d %H:%M")
        f.write(str(t) + '\n')
    return 'Recorded'


default_args = {
    'owner': 'airflow',
    'start_date': airflow.utils.dates.days_ago(2),
    'depends_on_past': False,
    'email': ['info@backendinsight.club'],
    'email_on_failure': True,
    'email_on_retry': False,
    'concurrency': 1,
    'retries': 0
}

with DAG('source_code_change_tests',
         description='A simple tutorial DAG',
         default_args=default_args,
         schedule_interval='@once',
         ) as dag:
    opr_hello = BashOperator(task_id='say_Hi',
                             bash_command='echo "Hi!!"',
                             dag=dag)

    opr_record_test_runtime = PythonOperator(task_id='record_test_runtime',
                               python_callable=test_runtime,
                               dag=dag)

    opr_make_assessment = BashOperator(task_id='make_assessment',
                             bash_command='Rscript /tmp/full_demo.R',
                             dag=dag)

    opr_report_above_average = BashOperator(task_id='report_above_average',
                             bash_command='Rscript /tmp/report_above_average.R',
                             dag=dag)

    opr_success_check = EmailOperator(
                                to='info@backendinsight.club',
                                task_id='email_task',
                                subject='The workflow has run successfully!',
                                html_content=" All the tasks in this workflow are completed successfully.",
                                dag=dag)


opr_hello >> opr_record_test_runtime >> opr_make_assessment >> opr_report_above_average >> opr_success_check
