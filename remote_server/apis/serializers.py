# import serializer from rest_framework
from rest_framework import serializers

# import model from models.py
from .models import GeeksModel, ProgramUsed

# Create a model serializer
class GeeksSerializer(serializers.HyperlinkedModelSerializer):
	# specify model and fields
	class Meta:
		model = GeeksModel
		fields = ('title', 'description')


class ProgramUsedSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = ProgramUsed
		fields =('last_time_saved','package_name', 'first_time_stamp', 'last_time_stamp', 'last_time_used', 'time_in_foreground')


