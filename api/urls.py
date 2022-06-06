
from django.urls import path
from rest_framework.authtoken.views  import obtain_auth_token

from api.views import AddALike, AddComment, AddReply, Cargreyview, Postview,Reguster,getComment
from .models import *
urlpatterns = [
    path('post/',Postview.as_view()),
    path('categry/',Cargreyview.as_view()),  
    path('Addlike/',AddALike.as_view()), 
    path('getComment/',getComment.as_view()), 
    path('Addcommet/',AddComment.as_view()), 
    path('Addreplay/',AddReply.as_view()), 
    path('login/',obtain_auth_token), 
    path('reguster/',Reguster.as_view),

]