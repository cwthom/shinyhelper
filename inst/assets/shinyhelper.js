// Script to update the shinyhelper_params input
$(document).ready(function() {
  
  $(".shinyhelper-icon").on("click", function() {
    
    var data = this.dataset;
    var nonce = Math.random();
    
    var modal_params = {
      size : data.modalSize,
      type : data.modalType,
      title : data.modalTitle,
      content : data.modalContent,
      nonce : nonce
    };
    
    Shiny.onInputChange("shinyhelper-modal_params", modal_params);
    
  });
  
});
