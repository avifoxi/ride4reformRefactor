var c3ext={};if(c3ext.generate=function(t){function n(){r()}function o(t,n,o,e){var i=t.slice(n[0],n[1]),r=1,u=i;if(u.length>e){var r=Math.ceil(i.length/e);u=u.splitIntoChunksOf(r).map(o)}return u}function e(t){return t[0]}function i(t){l.columns.removeAll(function(n){t.contains(n)})}function r(){var t=Q.copy(l);d(t),v(t)}if(null!=t.zoom2&&(u=t.zoom2.reducers||{},a=t.zoom2.enabled,_zoom2_factor=t.zoom2.factor||1,c=t.zoom2.maxItems),!a)return c3.generate(t);var u,a,c,l=Q.copy(t.data);if(null==c){var f=d3.select(t.bindto)[0][0];if(null!=f){var s=f.clientWidth,m=20;c=Math.ceil(s/m)}(null==c||10>c)&&(c=10)}var h=c3ext.ZoomBehavior({changed:n,bindto:t.bindto});h.enhance=function(){c*=2;var t=h.getZoom().totalItems;c>t&&(c=t),r()},h.dehance=function(){c=Math.ceil(c/2)+1,r()},h.maxItems=function(){return c};var d=function(t){if(null!=t.columns&&0!=t.columns.length){var n=h.getZoom();return n.totalItems!=t.columns[0].length-1&&(h.setOptions({totalItems:t.columns[0].length-1}),n=h.getZoom()),t.columns=l.columns.map(function(t){var i=t[0],r=u[i]||e,a=t.slice(1),l=o(a,n.currentZoom,r,c);return[i].concat(l)}),t}};d(t.data);var p=c3.generate(t),v=p.load.bind(p);return p.zoom2=h,p.load=function(t){t.unload&&(i(t.unload),delete t.unload),Q.copy(t,l),r()},p.unload=function(t){i(t),r()},p},c3ext.ZoomBehavior=function(t){function n(t){if(t[1]>f){var n=t[1]-f;t[0]-=n,t[1]-=n}if(t[0]<0){var n=-1*t[0];t[0]+=n,t[1]+=n}t[1]>f&&(t[1]=f),t[0]<0&&(t[0]=0)}function o(t,o){var i=Math.ceil(f/t),r=[o,o+i];n(r),s=r,e()}function e(){null!=v&&v(d.getZoom())}function i(){o(c,l)}function r(){var t=Math.ceil(f/c);return t}function u(){if(0!=g){var t=10,n=(t+g)/t;console.log({deltaY:g,multiply:n}),d.zoomAndPanByRatio(n,y),g=0}}function a(t){g+=t.deltaY,y=(t.offsetX-70)/(t.currentTarget.offsetWidth-70),h.set(150),t.preventDefault()}var c,l,f,s,m,h,d={__type:"ZoomBehavior"},p=t.bindto,v=t.changed||function(){},g=0,y=0;return d.setOptions=function(t){null==t&&(t={}),c=t.factor||1,l=0,f=t.totalItems||0,s=[0,f],v=t.changed||v},d.setOptions(t),d.getZoom=function(){return{totalItems:f,currentZoom:s.slice()}},d.factor=function(t,n){return 0==arguments.length?c:(c=t,1>c&&(c=1),void(n||i()))},d.left=function(t,n){if(0==arguments.length)return l;l=t,0>l&&(l=0);var o=r();l+o>f&&(l=f-o),console.log({left:l,pageSize:o}),n||i()},d.zoomAndPanByRatio=function(t,n){var o=r(),e=Math.round(o*n),u=l+e;d.factor(d.factor()*t,!0);var a=u;if(1!=t){var c=r(),f=Math.round(c*n);a=u-f}d.left(a,!0),i()},d.zoomIn=function(){d.zoomAndPanByRatio(2,0)},d.zoomOut=function(){d.zoomAndPanByRatio(.5,0)},d.panLeft=function(){d.zoomAndPanByRatio(1,-1)},d.panRight=function(){d.zoomAndPanByRatio(1,1)},d.reset=function(){l=0,c=1,i()},null!=p&&(m=$(t.bindto),m.mousewheel&&(h=new Timer(u),m.mousewheel(a))),d},"undefined"==typeof Q){var Q=function(){};Q.copy=function(t,n,o,e){if(null==e&&(e=0),100==e&&console.warn("Q.copy is in depth of 100 - possible circular reference"),o=o||{overwrite:!1},t==n||null==t)return n;if("object"!=typeof t)return o.overwrite||null==n?t:n;if("function"==typeof t.clone)return o.overwrite||null==n?t.clone():n;if(null==n&&(n=t instanceof Array?[]:{}),t instanceof Array){for(var i=0;i<t.length;i++){var r=t[i],u=n[i];u=Q.copy(r,u,o,e+1),n[i]=u}return n.splice(t.length,n.length-t.length),n}for(var a in t){var c=t[a],l=n[a];l=Q.copy(c,l,o,e+1),n[a]=l}return n}}if("undefined"==typeof Timer){var Timer=function(t,n){this.action=t,null!=n&&this.set(n)};Timer.prototype.set=function(t){null==t?t=this._ms:this._ms=t,this.clear(),null!=t&&(this.timeout=window.setTimeout(this.onTick.bind(this),t))},Timer.prototype.onTick=function(){this.clear(),this.action()},Timer.prototype.clear=function(){null!=this.timeout&&(window.clearTimeout(this.timeout),this.timeout=null)}}"undefined"==typeof Array.prototype.splitIntoChunksOf&&(Array.prototype.splitIntoChunksOf=function(t){for(var n=(Math.ceil(this.length/t),[]),o=0;o<this.length;o+=t)n.push(this.slice(o,o+t));return n});