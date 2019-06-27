// function to update the shinyhelper-modal_params input
function observe_helpers() {
  
  $(".shinyhelper-icon").on("click", function() {
    
    var data = this.dataset;
    var nonce = Math.random();
    
    var modal_params = {
      size : data.modalSize,
      type : data.modalType,
      title : data.modalTitle,
      content : data.modalContent,
      label : data.modalLabel,
      easyClose : data.modalEasyclose,
      fade : data.modalFade,
      nonce : nonce
    };
    
    Shiny.onInputChange("shinyhelper-modal_params", modal_params);
    
  });
  
}

// call the function on startup, to capture static helpers
$(document).ready(function() { observe_helpers() });

// call each time shiny values change, to capture dynamic observers
$(document).on("shiny:value", function() { 
  setTimeout(function() { observe_helpers() }, 500);
});

