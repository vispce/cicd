const exp = require('express');
const app = exp();
const path = require('path');
const port = 3000;

app.get('/',(req,res)=>{
	res.send('Hello');
});
app.listen(port,()=>{

	console.log('server started');
})
