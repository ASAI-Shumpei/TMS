import React, { useState, useEffect } from 'react';

import Timer from './components/Timer';

const RealTimerDetail = () => {
  const taskId = sessionStorage.getItem('selectedTaskId');   
  const [task, setTask] = useState([]); 

  useEffect(() => {
    fetch(`/api/tasks/${taskId}`)
      
      .then(response => response.json()) 
      
      .then(data => {
        setTask(data); 
      })
      .catch(error => console.error('Error fetching task:', error));
  }, []); 

  return (
    <div>
        <div key={task.id} className="task-card" style={{ marginBottom: '16px'}}>
          <h3>件名: {task.subject}</h3>
          <p>詳細: {task.detail}</p>
          
            期限: {new Date(task.due_date).toLocaleString()}
            <br />
            <Timer dueDate={task.due_date} />
        </div>
    </div>
  );
};
export default RealTimerDetail;