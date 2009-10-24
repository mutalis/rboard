// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function attachmentCallback(message, type, disabled) {
  $('#attachment_message').removeClass();
  $('#attachment_message').html(message);
  $('#attachment_message').addClass(type);
  if (disabled) {
    $('#attachment_submit').remove();
    $('#attachment_file').remove();
  };
}

// From: http://guymal.com/mycode/iframe_size
function resize(element) {
  $('#' + element.id).height = "1000";
  element.height = "1000";
}