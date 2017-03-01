function loadXMLDoc(url, xsl, elemId, params){
	var ctsResponse;
	var xmlhttp = new XMLHttpRequest();  
	xmlhttp.open("GET", url, true);
	xmlhttp.send('');  
	
	xmlhttp.onreadystatechange = function() {  
		if(xmlhttp.readyState == 4) {
		  if (console) {
  		    console.log("Finished loading text!");
  		  }
		  ctsResponse = xmlhttp.responseXML; 
		  nowGetXSLT(ctsResponse, xsl, elemId, params);
  		}
	}; 	
}


function nowGetXSLT(ctsResponse, xsl, elemId, params){
	var myURL = xsl;
	
	var xslhttp = new XMLHttpRequest();  
	xslhttp.open("GET", xsl, true);
	xslhttp.send('');  
	
	xslhttp.onreadystatechange = function() {  
		if(xslhttp.readyState == 4) {
		  if (console) {
		      console.log("Finished loading xslt!");
		  }
		  xsltData = xslhttp.responseXML;   		
		  processXML(ctsResponse, xsltData, elemId, params);
  		}	
	}; 
}

function processXML(ctsResponse, xsltData, elemId, params){
		var processor = null;
		var tempData = null;
		var tempHTML = "";
		processor = new XSLTProcessor();
		processor.importStylesheet(xsltData);
		if (params != null) {
			var param_array = params.split(',');
			for (var i=0; i<param_array.length; i++) {
				var keypair = param_array[i].split('=');
				// TODO handle namespaced parameters
				processor.setParameter(null, keypair[0], keypair[1]);
			}
		}
		tempData = processor.transformToDocument(ctsResponse);
		tempHTML = new XMLSerializer().serializeToString(tempData);	
		putTextOntoPage(tempHTML, elemId);
}



function putTextOntoPage(htmlText, elemId){
	// Catch any Markdown fields
	$("#"+elemId).html(htmlText);
	$(".tabs").tabs();
	$("#pagetitle").html($(".texttitle").html());
	$("#allcredits").html($(".textcredits").html());
	$("#" + elemId).removeClass("waiting");
        if ($(".linked_facs",htmlText).length > 0) {
            $(".facshint").show();
        }
	processMarkdown(elemId);
}

function processMarkdown(elemId){

	$(".md").each( function(i) {
		var mdText = $(this).html().trim();
		$(this).html(markdown.toHTML(mdText));
		//Remove class, so this doesn't get double-processed
		$(this).removeClass("md");

	});
	

	// if ( $("#" + elemId).find(".md").html() != null ) {
// 		var mdText = $("#" + elemId).find(".md").html().trim();
// 		console.log(mdText);
// 		$("#" + elemId).find(".md").html(markdown.toHTML(mdText));
// 	
// 	}
}

function assignIds(whichClass){
	$('.' + whichClass).each(function(index){
		$(this).addClass("waiting");
		$(this).html(" ");
		
		$(this).attr("id","cts_text_" + index);
		$(this).wrapInner("<a/>");
		if ( !($(this).hasClass("cts-clicked")) ){
				$(this).addClass("cts-clicked"); // prevent it from re-loading on every subsequent click
				var thisLink;
                                if ( $(this).attr("file") ) {
					thisLink = $(this).attr("file");
				} else if (  $(this).attr("cite").substring(0,7) == "http://"  ) {
					var tempPart = ( $(this).attr("cite").substring(7,$(this).attr("cite").length) );
					thisLink = "http://" + encodeURIComponent(tempPart);
					thisLink = $(this).attr("cite");
					
				} else {
					thisLink = urlOfCTS + $(this).attr("cite");
				}
				loadXMLDoc( thisLink, pathToXSLT, $(this).attr("id"), $(this).attr("data:xslt-params"));
			}
		
	});
}

function assignCiteIds(whichClass){
	$('.' + whichClass).each(function(index){
		$(this).addClass("waiting");
		$(this).html(" ");
		$(this).attr("id","cite_coll_" + index);
		$(this).wrapInner("<a/>");
		if ( !($(this).hasClass("cts-clicked")) ){
				$(this).addClass("cts-clicked"); // prevent it from re-loading on every subsequent click
				var thisLink;
				if (  $(this).attr("cite").substring(0,7) == "http://"  ) {
					thisLink = $(this).attr("cite");
					
				} else {
					thisLink = urlOfCite + $(this).attr("cite");
				}
				loadXMLDoc( thisLink, pathToCiteXSLT, $(this).attr("id"),$(this).attr("data:xslt-params"));
			}
		
	});
}

function toggleFacs() {
   $(".linked_facs").toggleClass("highlight");

}

$(document).ready(function(){
    processMarkdown("article");
    assignIds(textElementClass);	
    assignCiteIds(collectionElementClass);
    PerseidsLD.do_simple_query();
    PerseidsLD.do_verb_query();

});
