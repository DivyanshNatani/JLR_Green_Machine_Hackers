# Generated by Django 4.2.6 on 2023-10-17 13:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apis', '0005_alter_programused_last_time_saved'),
    ]

    operations = [
        migrations.AlterField(
            model_name='programused',
            name='last_time_saved',
            field=models.CharField(default='', max_length=100),
            preserve_default=False,
        ),
    ]