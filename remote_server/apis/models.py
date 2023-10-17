from django.db import models
from datetime import datetime

class GeeksModel(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()

    def __str__(self):
        return self.title

class ToDoTasks(models.Model):
    id = models.CharField(max_length=100, blank=True, primary_key=True)
    name = models.CharField(max_length=200)
    isDOne = models.BooleanField(default=False)

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        self.id = datetime.now()
        super(ToDoTasks, self).save(*args, **kwargs)

class ProgramUsed(models.Model):
    last_time_saved = models.CharField(max_length=100)
    package_name = models.CharField(max_length=100)
    first_time_stamp = models.CharField(max_length=100)
    last_time_stamp = models.CharField(max_length=100)
    last_time_used = models.CharField(max_length=100)
    time_in_foreground = models.FloatField()

    def __str__(self):
        return self.package_name




