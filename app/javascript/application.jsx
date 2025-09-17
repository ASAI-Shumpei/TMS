// Entry point for the build script in your package.json

import React from 'react';
import ReactDOM from 'react-dom/client';
import RealTimer from './Realtimer'; 
import RealTimerDetail from './RealTimerDetail'; 

document.addEventListener('DOMContentLoaded', () => {
  const RT = document.getElementById('timerRoot');
  if (RT) {
    const root = ReactDOM.createRoot(RT);
    root.render(<RealTimer />);
  }

  const RTD = document.getElementById('timerRootDetail');
  if (RTD) {
    const root = ReactDOM.createRoot(RTD);
    root.render(<RealTimerDetail />);
  }
});
