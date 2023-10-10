const express = require('express');
const path=require('path');
const blogs=require('../Data/blogs')
const router=express.Router();
// const arr=Array.from(blogs)
router.get('/', (req, res) => {
    res.sendFile(path.join(__dirname,"../views/index.html"))
  });
router.get('/blog', (req, res) => {
  // console.log(arr);
    blogs.forEach(e =>{
        console.log(e.title)
    });
  res.sendFile(path.join(__dirname,"../views/blogHome.html"))
  
  });
  router.get('/blogpost', (req, res) => {
    //myblog=blogs.filter((e)=>{
     //return e.slug==req.params.slug;
    //})
   //console.log(myblog)
  res.sendFile(path.join(__dirname,"../views/blogPage.html"))
  });
module.exports=router  