## How to setup SMTP server to enable Airflow to send email alerts

Edit ```airflow.cfg``` file to edit the smtp details for the mail server:

smtp_host = smtp.privateemail.com
smtp_starttls = True
smtp_ssl = False
smtp_user = info@backendinsight.club
smtp_password = <your_email_password>
smtp_port = 587
smtp_mail_from = info@backendinsight.club




#### reference
https://stackoverflow.com/questions/51829200/how-to-set-up-airflow-send-email/
