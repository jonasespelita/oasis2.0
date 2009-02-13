//  Beerwin's javascript Listview for DHTML pages
//  Copyright (C) Beerwin's World of Stuff, 2007
//  Open source stuff
//  If you modified this code, please let me know. Send a modified version to beerwin@xenzor.ro
//  Contributors: a.k.a. Put your name below in new comment line
//  Original by: Nagy Ervin
//


{

//  this temporary variable is required for internal purposes - do not remove
var LL_temp=0;

//  the object
function mylist(name,id,cols,colw1,colw2,colw3,colw4,colw5,colw6){
//  defining properties
this.name=name;
this.id=id;
this.width=100;
this.height=100;
this.del=true;
this.add=true;
this.edit=true;
this.font='arial, helvetica, sans-serif';
this.fontSize='12';
this.rowHeight='18';
this.rowBorder='1';
this.rowBorderColor='#CCCCCC';
this.ascending=true;
this.colCount=cols;
this.colWidths=new Array(cols);
this.selectedItem=new Array(cols);
this.header=new Array(cols);
this.sortColumn=0;
for (var ci=0;ci < this.colCount;ci++){
	switch (ci) {
		case 0:
			this.colWidths[ci]=colw1;
			break;
		case 1:
			this.colWidths[ci]=colw2;
			break;
		case 2:
			this.colWidths[ci]=colw3;
			break;
		case 3:
			this.colWidths[ci]=colw4;
			break;
		case 4:
			this.colWidths[ci]=colw5;
			break;
		case 5:
			this.colWidths[ci]=colw6;
			break;
		default:
			this.colWidths[ci]=100;
			break;
	}
	this.selected=-1;
}
//  creating the elements array - this will contain the list items
this.elements=new Array();
//  create the list skeleton
document.write('<div id="main_'+this.id+'" style="overflow:hidden; border-top:1px solid #999999; border-left:1px solid #999999; border-right:1px solid #FFFFFF; border-bottom:1px solid #FFFFFF; background:#D4D4D4">');
document.write('<div id="header_'+this.id+'" style="overflow:hidden; overflow-x:hidden; overflow-y:hidden; background:#D4D4D4; height:20px;"><table border=0 cellpadding=0 cellspacing=0><tr>');
for (var kk=0;kk<this.colCount;kk++){
document.write('<td><div id="btn_sort_'+this.id+'_'+kk+'" style="height:18px; border:1px solid #D4D4D4; border-top:0; border-left:0; width: '+(this.colWidths[kk]+1)+'px;"  onclick="javascript:'+this.name+'.sort('+kk+')">d</div></td>');
}
document.write('</tr></table></div><div id="'+id+'" style="overflow-y:hidden; overflow-x:hidden; border-bottom:1px solid #FFFFFF; border-top:1px solid #999999; background:#FFFFFF;"  onscroll="javascript:'+this.name+'.scrollme()"></div>');
document.write('<div id="scroll_'+id+'" style="height:16px; width: '+(this.width+299)+'px; overflow:hidden; background:#D4D4D4;" onscroll="javascript:'+this.name+'.scrollme()">f</div></div>');

//  event handler for the horizontal scrollbar (for scrolling the headers with the items) - Works only with IE and FF/Mozilla, Netscape
this.scrollme=function(){
  document.getElementById(this.id).scrollLeft=document.getElementById('scroll_'+this.id).scrollLeft;
  document.getElementById('header_'+this.id).scrollLeft=document.getElementById('scroll_'+this.id).scrollLeft;
} 

//  The drawer function
this.draw=function(){
  var s='';          
  var bgcol='#FFFFFF';
  var ccol='#000000';
  var selectedcol='Highlight';
  var selectedtext='HighlightText';
  var cw=0;
  for (var ci=0;ci<this.colCount;ci++){
  cw+=this.colWidths[ci];
  }
  var nnf=parseInt(this.height);
//  some width adjustments (leave them as they are)
  document.getElementById('main_'+this.id).style.width=parseInt(this.width)+22;
  document.getElementById('scroll_'+this.id).style.width=parseInt(this.width)+20;
  document.getElementById('header_'+this.id).style.width=parseInt(this.width)+20;
  document.getElementById(this.id).style.width=parseInt(this.width)+20;
  document.getElementById(this.id).style.height=this.height;
  
//  loop header drawing loop
for (var kk=0;kk<this.colCount;kk++){
document.getElementById('btn_sort_'+this.id+'_'+kk).style.width=this.colWidths[kk]+1;
var temp_vl=this.colWidths[kk]-1;
var ntheader='tdheader';
if (kk==this.sortColumn){
  if (this.ascending==true){
    ntheader='tdheader1';
  } else {
    ntheader='tdheader2';
  }
}
//  draw the dynamic header element
document.getElementById('btn_sort_'+this.id+'_'+kk).innerHTML='<A class="'+ntheader+'" href="#" style="height:20px; width: '+(temp_vl+1)+'px; display:block;">'+this.header[kk]+'</a>';
}
  s='<table border=0 cellpadding=0 cellspacing=0 width="'+cw+'">';
  
  var colch=1;
//  draw items
  for (var i=0; i<this.elements.length; i++){
//      set selected item's properties
      if (i==this.selected){
        bgcol='#ADDFFF;';
        brdtl='#003399';
        brdbr='#003399';
        if (colch==1){
          colch=0;
        } else {
          colch=1;
        }
        ccol=selectedtext;
      } else {
//  set the other items' properties      
        brdtl='#C0C0C0';
        brdbr='#C0C0C0';
        if (colch==1){
        bgcol='#FFFFFF';
        brdtl='#FFFFFF';
        colch=0;
        } else {
        bgcol='#EEEEEE';
        brdtl='#EEEEEE';
        colch=1;
        }
        ccol='#000000';
      }
   
//  draw the items
      s+='<tr id="'+this.id+'_'+i+'" style="color:'+ccol+'; background:'+bgcol+'; font-family:'+this.font+'; font-size:'+this.fontSize+'px; height:'+this.rowHeight+'px; border:'+this.rowBorder+'px solid '+this.rowBorderColor+';" valign="middle" onclick="javascript:'+this.name+'.selectItem('+i+')">';
      for (var j=0;j < this.colCount;j++){
      var ss = this.elements[i][j];
      s+='<td style="width: '+(this.colWidths[j]-1)+'px; height: '+this.rowHeight+'px; border-right:1px solid '+brdbr+'; border-bottom:1px solid '+brdbr+'; border-top:1px solid '+brdtl+'; border-left:1px solid '+brdtl+'"><div style="cursor:default; width:'+this.colWidths[j]+'px;  height: '+this.rowHeight+'px; overflow:hidden;">'+ss+'</div></td>'
      }
      s+='</tr>';
  }                         
  s+='</table>';
  document.getElementById(this.id).innerHTML=s;
  
  s='<table border=0 cellpadding=0 cellspacing=0 width="'+parseInt(cw)+'"><tr><td>&nbsp;</td></tr></table>';
  document.getElementById('scroll_'+this.id).innerHTML=s;
}

//  set list width and height in pixels
this.setDims=function(w,l){
  this.width=w;
  this.height=l;
  this.draw();
  document.getElementById(this.id).style.width=this.width;
  document.getElementById(this.id).style.height=this.height;
}

//  add an item and redraw
this.add=function(){
  var newitem=new Array(this.colCount);
  var canadd=true;
  for (var j=0;j<this.colCount;j++){
  var ni = prompt('Enter a value','');
  if (!ni){
    if (ni == ''){
    alert('Please enter a name!')}
  } else {
    newitem[j]=ni;
  }
  }
  for (j=0;j<this.colCount;j++){
    if ((!newitem[j])||(newitem[j] == '')){
      canadd=false;
    }
  }
  if (canadd==true){
  var i=this.elements.length;
  this.elements[i]=newitem;
  this.draw();
  }
  
}

//  add an item without redraw - for dynamic item adding (for server-side scripts) or even static stuff when there are many
this.silentAdd=function(newitem){

  var i=this.elements.length;
  c=this.colCount;
  this.elements[i] = new Array(this.colCount);
  for (var j=0;j<newitem.length; j++){
  this.elements[i][j]=newitem[j];
  }

}


//  update the header
this.updateHeader=function(newitem){
  c=this.colCount;
  for (var j=0;j<newitem.length; j++){
  this.header[j]=newitem[j];
  }
  this.draw();
}

//  select an item when clicked
this.selectItem=function(item){
this.selected=item;
this.selectedItem=this.elements[this.selected];
this.draw();
}

//  drop selected item from the list
this.delItem=function(){

  if (this.elements.length==0){ 
    alert('Sorry, list empty!')
  } else {
    if ((this.selected < 0)|| (this.selected > this.elements.length)){
      alert('List index out of bounds!('+this.selected+')');
    } else {
      this.elements[this.selected]=this.elements[this.elements.length-1];
      this.elements.pop();
      this.selected=-1;
      this.draw();
    }
  }
}

//  drop all items from the list
this.clear=function(){
  var l=this.elements.length;
  for (var i=0;i<l;i++){
    this.elements.pop();
  }
  this .selected=-1;
  this.draw();
}


//  the column sort function (this does the sorting) between two items
this.sortbyCol=function(a,b){
    var tmp=LL_temp;
    var x = a[tmp].toLowerCase();
    var y = b[tmp].toLowerCase();
    return ((x < y) ? -1 : ((x > y) ? 1 : 0));
}

//  sort the list by column header click up/down and redraw
this.sort=function(colu){
this.sortColumn=colu;
LL_temp=colu;
  var theValue='';
  if (this.ascending==true){
    this.ascending=false;
    theValue='Sort: DESC';
  } else {
    this.ascending=true;
    theValue='Sort: ASC';
  }
  this.elements.sort(this.sortbyCol);
  if (this.ascending==false){
    this.elements.reverse();
  }
  this.draw();
  
  //document.getElementById('btn_sort_'+this.id).value=theValue;
}

//  Set column width for a certain column: cl:column index; w:width in pixels - you can set arbitrary widths for each column
this.setColWidth=function(cl,w){

  if ((!w)||(w=='')){
    w=this.colWidths[cl];
  } else {
  
  this.colWidths[cl]=parseInt(w);
  this.draw();
  }
  
}

}

}