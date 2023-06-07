$(function() {
  $("[name=attach]").change(function() {
    if (this.files && this.files[0]) {
      const reader = new FileReader();
      const fileExtension = this.files[0].name.split('.').pop().toLowerCase();

      reader.onload = function(e) {
        if (fileExtension === 'jpg' || fileExtension === 'jpeg' || fileExtension === 'png') {
            $(".file-preview").attr("src", e.target.result);
        }
      };

      reader.readAsDataURL(this.files[0]);
    }
  });

  $("[name=attach]").change(function() {
    if (this.files && this.files[0]) {
      const reader = new FileReader();
      const fileExtension = this.files[0].name.split('.').pop().toLowerCase();

      reader.onload = function(e) {
        if (fileExtension === 'jpg' || fileExtension === 'jpeg' || fileExtension === 'png') {
          $(".profilePreview").attr("src", e.target.result);
        }
      };

      reader.readAsDataURL(this.files[0]);
    }
  });
});
