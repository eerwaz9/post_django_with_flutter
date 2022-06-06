from urllib import response
from rest_framework import serializers
from .models import *
from django.contrib.auth import get_user_model
from django import *
from rest_framework.authtoken.models import Token

User=get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta: 
        model=User
        fields=('id','username','email','password')
        extra_kwargs={'password':{'write_only':True,'required':True}}
    def create(self,validated_data):
        user=User.objects.create_user(**validated_data)
        Token.objects.create(user=user)
        return user
        
class PostrSerializer(serializers.ModelSerializer):
    class Meta: 
        model=Post
        fields='__all__'
        depth=1
    
class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model=Commat
        fields='__all__'
    def to_representation(self,instance):
        response=super().to_representation(instance)
        response['user']=UserSerializer(instance.user).data
        return response
class RepoySerializer(serializers.ModelSerializer):
    
    class Meta:
        model=Reolay
        fields='__all__'
        #depth=1
    def to_representation(self,instance):
        response=super().to_representation(instance)
        response['user']=UserSerializer(instance.user).data
        return response


class CargreySerializer(serializers.ModelSerializer):
    class Meta:
        model=Cargrey
        fields='__all__'
        depth=1