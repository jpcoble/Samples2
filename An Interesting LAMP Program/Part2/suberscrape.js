ret = iimPlay("AlaCourtLogin");
﻿for (var i=0; i<14; i++)
{
ret = iimSet("myloop1", i);
var myDelay;
myDelay=Math.floor(Math.random()*7)+3
iimSet("Mydelay", myDelay);
var myDelay2;
myDelay2=Math.floor(Math.random()*12)+8
iimSet("Mydelay2", myDelay2);
ret = iimPlay("AlaCourtSuberMulti.iim")
}
