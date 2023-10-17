# import viewsets
from rest_framework import viewsets
from rest_framework.response import Response
from django.http import HttpResponse
# import local data
from .serializers import GeeksSerializer, ProgramUsedSerializer
from .models import GeeksModel, ProgramUsed

# create a viewset

class GeeksViewSet(viewsets.ModelViewSet):
	# define queryset
	queryset = GeeksModel.objects.all()

	# specify serializer to be used
	serializer_class = GeeksSerializer

class ProgramUsedViewSet(viewsets.ModelViewSet):
	# define queryset
	queryset = ProgramUsed.objects.all()



	# specify serializer to be used
	serializer_class = ProgramUsedSerializer

	def create(self, request, *args, **kwargs):
		serializer = self.get_serializer(data=request.data, many=True)

		if serializer.is_valid():
			serializer.save()
			return Response(serializer.data, status=201)
		return Response(serializer.errors, status=400)

	def list(self, request, *args, **kwargs):
		# queryset = self.filter_queryset(self.get_queryset())
		# queryset.fi
		obj = ProgramUsed.objects.last()

		if obj:
			resp = {'last_time_saved': obj.last_time_saved}
			print(resp)
			return Response(resp)
		else:
			resp = {'last_time_saved': "2023-10-16 17:37:19.201050"}
			print(resp)
			return Response(resp)






		return super().list(request, *args, **kwargs)
