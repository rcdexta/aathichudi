/**
 * Gradient text jQuery plugin
 * 
 * Replaces text elements with a canvas element of the same size
 * that shows the text with a gradient color.
 * 
 * Dual licensed under the MIT and GPL3 licenses.
 * 
 * @author      Codefocus (http://www.codefocus.ca/)
 * @copyright   2011 Codefocus
 * @license     http://www.gnu.org/licenses/gpl-3.0.html
 * @license     http://www.opensource.org/licenses/mit-license.php
 * @version     0.1
 * @link        http://www.codefocus.ca/
 */
(function($){$.fn.gradienttext=function(m){var m=$.extend({colors:['#000000','#FFFFFF'],style:'vertical',shadow:false,shadow_color:'#000000',shadow_offset_x:1,shadow_offset_x:1,shadow_blur:1},m);$(this).each(function(){try{var a=document.createElement('canvas');a.width=$(this).width();a.height=$(this).height();var b=a.getContext("2d")}catch(e){return false}var c=$(this).css('font-family');var d=$(this).css('font-size');var f=$(this).css('font-weight');var g=$(this).css('line-height');var h=$(this).text();b.textBaseline='top';b.font=f+' '+d+' '+c;var i=b.measureText(h);switch(m.style){case'horizontal':var j=b.createLinearGradient(0,0,i.width,0);break;case'vertical':default:var j=b.createLinearGradient(0,0,0,a.height);break}var k=1/m.colors.length;for(var l=0;l<m.colors.length;++l){j.addColorStop(l*k,m.colors[l])}b.fillStyle=j;if(m.shadow===true){b.shadowOffsetX=m.shadow_offset_x;b.shadowOffsetY=m.shadow_offset_x;b.shadowBlur=m.shadow_blur;b.shadowColor=m.shadow_color}b.fillText(h,0,0);$(this).replaceWith($(a))})}})(jQuery);

