import React, { useState, useEffect } from 'react';

import Timer from './components/Timer';

const RealTimer = () => {
  const [tasks, setTasks] = useState([]); 

  useEffect(() => {
    fetch('/api/tasks')
      
      .then(response => response.json()) 
      
      .then(data => {
        setTasks(data); 
      })
      .catch(error => console.error('Error fetching tasks:', error));
  }, []); 

  const handleCardClick = (taskId) => {
    // 💡 1. クリックされたタスクのIDをセッションストレージに保存
    sessionStorage.setItem('selectedTaskId', taskId);
    
    // 💡 2. ページ遷移（Railsのshowアクションへ）
    window.location.href = `/tasks/${taskId}`;
  };

  return (
    <div>
      {tasks.map(task => (
        <div key={task.id} className="task-card"  onClick={() => handleCardClick(task.id)} style={{ marginBottom: '16px'}}>
          <h3>件名: {task.subject}</h3>
          <p>詳細: {task.detail}</p>
          
            期限: {new Date(task.due_date).toLocaleString()}
            <br />
            <Timer dueDate={task.due_date} />
        </div>
      ))}
    </div>
  );
};
export default RealTimer;