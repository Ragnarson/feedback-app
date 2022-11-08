window.activeXMLHttpRequests = 0;

(function (open) {
  return XMLHttpRequest.prototype.open = function (method, url, async, user, pass) {
    this.addEventListener("readystatechange", function () {
      if (this.readyState == 1) {
        window.activeXMLHttpRequests++;
      } else if (this.readyState == 4) {
        window.activeXMLHttpRequests--;
      }
    }, false);

    return open.call(this, method, url, async, user, pass);
  };
})(XMLHttpRequest.prototype.open);
