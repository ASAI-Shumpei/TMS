import React, { useState, useEffect } from 'react';


const Timer = ({ dueDate }) => {
  
  const calculateTimeLeft = () => {
    
    if (!dueDate) return 0;
    
    const dueTime = new Date(dueDate);
    const now = new Date();
    const differenceInSeconds = Math.max(0, Math.floor((dueTime - now) / 1000));
    return differenceInSeconds;
  };

  
  const [timeLeft, setTimeLeft] = useState(calculateTimeLeft());

 
  useEffect(() => {
    const timerId = setInterval(() => {
      setTimeLeft(calculateTimeLeft());
    }, 1000);

    
    if (timeLeft <= 0) {
      clearInterval(timerId);
    }
    
    return () => clearInterval(timerId);
  }, [timeLeft, dueDate]); 

  
  const formatTime = (seconds) => {
    
    if (seconds <= 0) {
      return '期限切れ';
    }
    
    const days = Math.floor(seconds / (3600 * 24));
    const hours = Math.floor((seconds % (3600 * 24)) / 3600);
    const minutes = Math.floor((seconds % 3600) / 60);
    const remainingSeconds = seconds % 60;
    
    let result = '';
    if (days > 0) result += `${days}日`;
    if (hours > 0) result += `${hours}時間`;
    if (minutes > 0) result += `${minutes}分`;
    result += `${remainingSeconds}秒`;
    return result;
  };

  return (
    <div>
      残り時間: {formatTime(timeLeft)}
    </div>
  );
};

export default Timer;