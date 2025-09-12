// Entry point for the build script in your package.json

import React from 'react';
import ReactDOM from 'react-dom/client';
import RealTimer from './Realtimer'; 

document.addEventListener('DOMContentLoaded', () => {
  const RT = document.getElementById('timerRoot');
  if (RT) {
    const root = ReactDOM.createRoot(RT);
    root.render(<RealTimer />);
  }
});
