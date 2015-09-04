

window._JsAsMessage_={},
pageReady=false;

function JsAsMessage(flashId){
	
	if(window._JsAsMessage_[flashId]) return window._JsAsMessage_[flashId];
	
	if (navigator.appName.indexOf("Microsoft") != -1) {
		this.object= window[flashId];
	} else {
		this.object= document[flashId]; 
	}
	if(!this.object) this.object=document.getElementById(flashId);
	
	this.handles={};
	
	
	
	var self=this,flashLoaded=false;
		
	_bind("readystatechange",JsAsMessage_checkReady);
	
	
	
	this.bind('allReady',function(){
		
	});

	
	window._JsAsMessage_[flashId]=this;
}

JsAsMessage.prototype={
	constructor:JsAsMessage,
	bind:function(ev,handle){
		if(typeof ev =='string'&&typeof handle =='function'&&ev){
			this.handles[ev]=this.handles[ev]||[];
			this.handles[ev].push(handle);
		}else throw 'wrong args in method bind';
	},
	postMessage:function(msg){
		this.object.JsAsMessage_as_trigger('message',msg);
	},
	
}

// JavaScript Document







function JsAsMessage_js_trigger(flashId,ev,msg){
	var handles,flash=window._JsAsMessage_[window._JsAsMessage_];
	if(flash)if(handles=flash.handles[ev])
		for(var i=0,l=handles.length;i<l;i++)
			handles[i](msg);
}

//AS检测到document ready就说明已经准备好
function JsAsMessage_js_checkReady(){
		return document.readyState == "complete";
	}


function _bind(ev,handle,elem){
	elem=elem||document;
	if (window.attachEvent) {
		elem.attachEvent("on"+ev, handle);
	} else if (window.addEventListener) {
		elem.addEventListener(ev, handle, false);
	}
}














