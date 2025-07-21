// Entry point for the JavaScript import map

document.addEventListener("DOMContentLoaded", () => {
    const banner = document.getElementById("cookie-banner");
    const acceptBtn = document.getElementById("accept-cookies");
    const refuseBtn = document.getElementById("refuse-cookies");
  
    if (acceptBtn) {
      acceptBtn.addEventListener("click", () => {
        document.cookie = "cookies_consent=accepted; path=/; max-age=" + 60 * 60 * 24 * 365;
        if (banner) banner.remove();
      });
    }
  
    if (refuseBtn) {
      refuseBtn.addEventListener("click", () => {
        document.cookie = "cookies_consent=refused; path=/; max-age=" + 60 * 60 * 24 * 365;
        if (banner) banner.remove();
      });
    }
  });
  
