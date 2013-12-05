ret = iimPlay("AlaCourtLogin");
for (var i=0; i<2; i++)
{
ret = iimSet("JeffersonLoop", i);
var myDelay;
myDelay=Math.floor(Math.random()*7)+3
iimSet("Mydelay", myDelay);
ret = iimPlay("JeffersonHotSheet.iim")
}
for (var j=0; j<2; j++)
{
ret = iimSet("BessemerLoop", j);
var myDelay;
myDelay=Math.floor(Math.random()*7)+3
iimSet("Mydelay", myDelay);
ret = iimPlay("BessemerHotSheet.iim")
}
for (var k=0; k<2; k++)
{
ret = iimSet("BlountLoop", k);
var myDelay;
myDelay=Math.floor(Math.random()*7)+3
iimSet("Mydelay", myDelay);
ret = iimPlay("BlountHotSheet.iim")
}
for (var l=0; l<2; l++)
{
ret = iimSet("ShelbyLoop", l);
var myDelay;
myDelay=Math.floor(Math.random()*7)+3
iimSet("Mydelay", myDelay);
ret = iimPlay("ShelbyHotSheet.iim")
}


