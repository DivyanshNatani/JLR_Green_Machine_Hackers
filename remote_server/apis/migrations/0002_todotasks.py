# Generated by Django 4.2.6 on 2023-10-11 20:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apis', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='ToDoTasks',
            fields=[
                ('id', models.CharField(blank=True, default='2023-10-11 20:13:24.238908', max_length=100, primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=200)),
                ('isDOne', models.BooleanField(default=False)),
            ],
        ),
    ]
