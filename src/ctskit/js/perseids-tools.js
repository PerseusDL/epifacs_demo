var PerseidsTools;
PerseidsTools = PerseidsTools || {};
PerseidsTools.LDResults = {};

PerseidsTools.LDResults.thumbs = function(_elem, _results) {

  if ( _results.length == 0 ) {
    $( '.perseidsld_query_obj_simple' ).remove();
  }
  for ( var i=0, ii=_results.length; i<ii; i++ ) {
    var img = '<img src="'+ urlOfImgService + _results[i] + '&w=100&request=GetBinaryImage" data-facs="' + _results[i] + '" onclick="linkToImage(this);" title="Click to Zoom"/>';
    $( _elem ).append( img );
  }
}


