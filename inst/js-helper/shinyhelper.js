// Script to update the shinyhelper_params input
$(document).ready(function() {
  
  $(".shinyhelper-icon").on("click", function() {
    
    var modal_size = this.getAttribute("modal_size");
    var modal_type = this.getAttribute("modal_type");
    var modal_title = this.getAttribute("modal_title");
    var modal_content = this.getAttribute("modal_content");
    var nonce = Math.random();
    
    var modal_params = {
      size : modal_size,
      type : modal_type,
      title : modal_title,
      content : modal_content,
      nonce : nonce
    };
    
    Shiny.onInputChange("shinyhelper_params", modal_params);
    
  });
  
});
