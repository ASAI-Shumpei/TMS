// Entry point for the build script in your package.json

import React from 'react';
import ReactDOM from 'react-dom/client';
import HelloWorld from './components/Helloworld'; 

document.addEventListener('DOMContentLoaded', () => {
  const rootElement = document.getElementById('react-root');
  if (rootElement) {
    const root = ReactDOM.createRoot(rootElement);
    root.render(<HelloWorld />);
  }
});
