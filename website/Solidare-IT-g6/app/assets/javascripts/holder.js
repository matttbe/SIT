/*
Holder - 2.1 - client side image placeholders
(c) 2012-2013 Ivan Malopinsky / http://imsky.co
Provided under the MIT License.
Commercial use requires attribution.
*/
var Holder = Holder || {};
(function (app, win) {
var preempted = false,
fallback = false,
canvas = document.createElement('canvas');
if (!canvas.getContext) {
fallback = true;
} else {
if (canvas.toDataURL("image/png")
.indexOf("data:image/png") < 0) {
//Android doesn't support data URI
fallback = true;
} else {
var ctx = canvas.getContext("2d");
}
}
var dpr = 1, bsr = 1;
if(!fallback){
dpr = window.devicePixelRatio || 1,
bsr = ctx.webkitBackingStorePixelRatio || ctx.mozBackingStorePixelRatio || ctx.msBackingStorePixelRatio || ctx.oBackingStorePixelRatio || ctx.backingStorePixelRatio || 1;
}
var ratio = dpr / bsr;
//getElementsByClassName polyfill
document.getElementsByClassName||(document.getElementsByClassName=function(e){var t=document,n,r,i,s=[];if(t.querySelectorAll)return t.querySelectorAll("."+e);if(t.evaluate){r=".//*[contains(concat(' ', @class, ' '), ' "+e+" ')]",n=t.evaluate(r,t,null,0,null);while(i=n.iterateNext())s.push(i)}else{n=t.getElementsByTagName("*"),r=new RegExp("(^|\\s)"+e+"(\\s|$)");for(i=0;i<n.length;i++)r.test(n[i].className)&&s.push(n[i])}return s})
//getComputedStyle polyfill
window.getComputedStyle||(window.getComputedStyle=function(e){return this.el=e,this.getPropertyValue=function(t){var n=/(\-([a-z]){1})/g;return t=="float"&&(t="styleFloat"),n.test(t)&&(t=t.replace(n,function(){return arguments[2].toUpperCase()})),e.currentStyle[t]?e.currentStyle[t]:null},this})
//http://javascript.nwbox.com/ContentLoaded by Diego Perini with modifications
function contentLoaded(n,t){var l="complete",s="readystatechange",u=!1,h=u,c=!0,i=n.document,a=i.documentElement,e=i.addEventListener?"addEventListener":"attachEvent",v=i.addEventListener?"removeEventListener":"detachEvent",f=i.addEventListener?"":"on",r=function(e){(e.type!=s||i.readyState==l)&&((e.type=="load"?n:i)[v](f+e.type,r,u),!h&&(h=!0)&&t.call(n,null))},o=function(){try{a.doScroll("left")}catch(n){setTimeout(o,50);return}r("poll")};if(i.readyState==l)t.call(n,"lazy");else{if(i.createEventObject&&a.doScroll){try{c=!n.frameElement}catch(y){}c&&o()}i[e](f+"DOMContentLoaded",r,u),i[e](f+s,r,u),n[e](f+"load",r,u)}}
//https://gist.github.com/991057 by Jed Schmidt with modifications
function selector(a){
a=a.match(/^(\W)?(.*)/);var b=document["getElement"+(a[1]?a[1]=="#"?"ById":"sByClassName":"sByTagName")](a[2]);
var ret=[]; b!==null&&(b.length?ret=b:b.length===0?ret=b:ret=[b]); return ret;
}
//shallow object property extend
function extend(a,b){var c={};for(var d in a)c[d]=a[d];for(var e in b)c[e]=b[e];return c}
//hasOwnProperty polyfill
if (!Object.prototype.hasOwnProperty)
/*jshint -W001, -W103 */
Object.prototype.hasOwnProperty = function(prop) {
var proto = this.__proto__ || this.constructor.prototype;
return (prop in this) && (!(prop in proto) || proto[prop] !== this[prop]);
}
/*jshint +W001, +W103 */
function text_size(width, height, template) {
height = parseInt(height, 10);
width = parseInt(width, 10);
