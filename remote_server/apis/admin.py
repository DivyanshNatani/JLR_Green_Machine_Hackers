from django.contrib import admin
from .models import GeeksModel, ToDoTasks, ProgramUsed
# Register your models here.
# admin.site.register(GeeksModel)
# admin.site.register(ToDoTasks)



class ProgramUsedAdmin(admin.ModelAdmin):
    list_display=['package_name','first_time_stamp','time_in_foreground']
    list_filter=['package_name']
    search_fields=['package_name']

admin.site.register(ProgramUsed, ProgramUsedAdmin)