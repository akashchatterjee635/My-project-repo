const express = require('express')
const app = express()
const port = 3000
const path=require('path')

app.use(express.static(path.join(__dirname,"public")))
app.use("/",require(path.join(__dirname,"routes/blog.js")))





app.listen(port, () => {
  console.log(`Blog app listening on port http://localhost:${port}`)
})