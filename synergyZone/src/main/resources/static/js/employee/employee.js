$(function(){
  $("[name=attach]").change(function(){
    if(this.files && this.files[0]){
      const reader = new FileReader();
      
      reader.onload = function(e){
        $(".target").html("<img src='" + e.target.result + " alt='Image Preview'>");
      };
      
      reader.readAsDataURL(this.files[0]);
    }
    
  });
  
  $("[name=attach]").change(function() {
    if (this.files && this.files[0]) {
      const reader = new FileReader();

      reader.onload = function(e) {
        $(".profilePreview").attr("src", e.target.result);
      };

      reader.readAsDataURL(this.files[0]);
    }
  });
});