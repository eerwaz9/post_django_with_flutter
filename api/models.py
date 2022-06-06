from django.db import models
from django.contrib.auth.models import User


class Cargrey(models.Model):
     title =models.CharField(max_length=150) 
     def __str__(self):
          return self.title
    
class Post(models.Model):
     cargrey=models.ForeignKey(Cargrey ,models.CASCADE)
     title=models.CharField(max_length=150)
     code=models.TextField(blank=True,null=True)
     content=models.TextField()
     date=models.DateField(auto_now_add=True)
     def __str__(self):
          return self.title
     
class Commat(models.Model):
     user=models.ForeignKey(User,models.CASCADE)
     post=models.ForeignKey(Post,models.CASCADE)
     title=models.TextField()
     time=models.DateField(auto_now_add=True)
     def __str__(self):
          return self.title

class Reolay(models.Model):
     user=models.ForeignKey(User,on_delete=models.CASCADE)
     commat=models.ForeignKey(Commat,on_delete=models.CASCADE)
     title=models.TextField()
     time=models.DateField(auto_now_add=True)
     def __str__(self): 
          return f"User={self.user.username} || Commat={self.commat}"
    
class Like(models.Model):
     post=models.ForeignKey(Post,on_delete=models.CASCADE)
     user=models.ForeignKey(User,on_delete=models.CASCADE)
     like=models.BooleanField(default=False)
     def __str__(self):
          return f"Post={self.post.id} || User={self.user.username} || Like={self.like}"


