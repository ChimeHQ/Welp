window.onload = function() {
  setupTOC();
}

function isHelpViewerAvailable() {
  return "HelpViewer" in window && "showTOCButton" in window.HelpViewer;
}

function setupTOC() {
  if (!isHelpViewerAvailable()) {
    return;
  }
  
  window.setTimeout(function () {
    window.HelpViewer.showTOCButton(true, toggleNavigation, toggleNavigation);
  }, 100);
}

function toggleNavigation() {
}
