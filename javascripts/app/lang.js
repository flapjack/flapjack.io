/*
Copyright 2008-2013 Concur Technologies, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may
not use this file except in compliance with the License. You may obtain
a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
License for the specific language governing permissions and limitations
under the License.
*/
!function(e){function t(e){if(e&&""!==e){$(".lang-selector a").removeClass("active"),$(".lang-selector a[data-language-name='"+e+"']").addClass("active");for(var t=0;t<i.length;t++)$(".highlight."+i[t]).hide();$(".highlight."+e).show(),$(window.location.hash).get(0).scrollIntoView(!0)}}function o(e){if(history){var t=window.location.hash;t&&(t=t.replace(/^#+/,"")),history.pushState({},"","?"+e+"#"+t),localStorage.setItem("language",e)}}function n(e){var o=(e[0],localStorage.getItem("language"));i=e,""!==location.search.substr(1)&&-1!=jQuery.inArray(location.search.substr(1),i)?(t(location.search.substr(1)),localStorage.setItem("language",location.search.substr(1))):t(null!==o&&-1!=jQuery.inArray(o,i)?o:i[0])}var i=[];e.setupLanguages=n,e.activateLanguage=t,$(function(){$(".lang-selector a").on("click",function(){var e=$(this).data("language-name");return o(e),t(e),!1}),window.onpopstate=function(){t(window.location.search.substr(1))}})}(window);