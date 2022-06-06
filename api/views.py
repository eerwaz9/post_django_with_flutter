
import re
from urllib import response
from rest_framework.views import APIView
from rest_framework.response import Response
from .models import *
from .serializers import *
from  rest_framework.permissions import IsAuthenticated
from  rest_framework.authentication import  TokenAuthentication


class Postview(APIView):
    permission_classes=[IsAuthenticated,]
    authentication_classes=[TokenAuthentication,]
    def get(self,request):
        query=Post.objects.all()
        serializer=PostrSerializer(query,many=True)
        data=[]
        for post in serializer.data:
            post_like=Like.objects.filter(
                post=post['id']).filter(like=True).count()
            mylike = Like.objects.filter(post=post['id']).filter(
                user=request.user).first()
            if mylike:
                post['like'] = mylike.like
            else:
                post['like'] = False
            post['totalike']=post_like
            comment_query=Commat.objects.filter(post=post['id']).order_by('-id')
            comment_serializer=CommentSerializer(comment_query,many=True)
            comment_data=[]
            for commat in comment_serializer.data:
                repuy_query=Reolay.objects.filter(commat=commat['id'])
                reploy_serializer=RepoySerializer(repuy_query,many=True)
                commat['reploy']=reploy_serializer.data
                comment_data.append(commat)
            post['Comment']=comment_data
            data.append(post)
        return Response(data)
    
class Cargreyview (APIView):
     permission_classes=[IsAuthenticated,]
     authentication_classes=[TokenAuthentication,]
     def get(self,request):
        query=Cargrey.objects.all()
        serializer=CargreySerializer(query,many=True)
        return Response(serializer.data)

            
    
class AddALike (APIView):  
    permission_classes=[IsAuthenticated,]
    authentication_classes=[TokenAuthentication,]
    def post(self,request):
        try:
            data = request.data
            c_user = request.user
            post_id = data['id']
            post_obj = Post.objects.get(id=post_id)
            like_obj = Like.objects.filter(
                post=post_obj).filter(user=c_user).first()
            if like_obj:
                old_like = like_obj.like
                like_obj.like = not old_like
                like_obj.save()
            else:
                Like.objects.create(
                    post=post_obj,
                    user=c_user,
                    like=True,
                )
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)
    
    
class AddComment (APIView):  
    permission_classes=[IsAuthenticated,]
    authentication_classes=[TokenAuthentication,]
    def post(self,request):
        try:
            c_user = request.user
            data = request.data
            post_id = data['postid']
            post_obj = Post.objects.get(id=post_id)
            comment_txt=data['comment']
            Commat.objects.create(
                user=c_user,
                post=post_obj,
                title=comment_txt, )
            response_mgs={'error':False, "postid":post_id}
        except:
            response_mgs={'error':True}
        return Response(response_mgs)
    
    
    
    
class AddReply(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]
    def post(self, request):
        try:
            c_user = request.user
            data = request.data
            comment_id = data['commentid']
            comment_obj = Commat.objects.get(id=comment_id)
            replytext = data['replytext']
            Reolay.objects.create(
                user=c_user,
                comment=comment_obj,
                title=replytext,
            )
            response_msg = {'error': False}
        except:
            response_msg = {'error': False}
        return Response(response_msg)
    
    
class Reguster(APIView):
    def post(self,request):
        serializers=UserSerializer(data=request.data)
        if serializers.is_valid():
            serializers.save()
            return Response ({ "error" :False})
        return Response ({ "error" :True})
    def get(self,request):
         query=User.objects.all()
         serializer=UserSerializer(query,many=True)
         return Response(serializer.data)
     
class getComment (APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]
    def get(self,request):
        query=Commat.objects.all()
        serializer=CommentSerializer(query,many=True)
        return Response(serializer.data)