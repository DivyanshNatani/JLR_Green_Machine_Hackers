# Generated by Django 4.2.6 on 2023-10-17 09:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apis', '0003_alter_todotasks_id'),
    ]

    operations = [
        migrations.CreateModel(
            name='ProgramUsed',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('last_time_saved', models.DateTimeField(blank=True)),
                ('package_name', models.CharField(max_length=100)),
                ('first_time_stamp', models.CharField(max_length=100)),
                ('last_time_stamp', models.CharField(max_length=100)),
                ('last_time_used', models.CharField(max_length=100)),
                ('time_in_foreground', models.FloatField()),
            ],
        ),
    ]
