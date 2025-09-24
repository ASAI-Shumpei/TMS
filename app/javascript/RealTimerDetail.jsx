import React, { useState, useEffect } from 'react';

import Timer from './components/Timer';
import DeleteButton from './components/Deletebutton'; 

const RealTimerDetail = () => {
  const Path = window.location.pathname; 
  const [task, setTask] = useState([]); 
  const [csrfToken, setCsrfToken] = useState('');

  useEffect(() => {
    const token = document.querySelector('meta[name="csrf-token"]')
      ? document.querySelector('meta[name="csrf-token"]').content
      : '';
    setCsrfToken(token);

    fetch(`/api${Path}`)
      
      .then(response => response.json()) 
      
      .then(data => {
        setTask(data); 
      })
      .catch(error => console.error('Error fetching task:', error));
  }, []); 

  
  const handleDeleteSuccess = (deletedTaskId) => {
    setTask(prevTasks => prevTasks.filter(task => task.id !== deletedTaskId));
  };


  return (
    
        <div key={task.id} className="task-card" style={{ marginBottom: '16px'}}>
          <h3>件名: {task.subject}</h3>
          <p>詳細: {task.detail}</p>
          
            期限: {new Date(task.due_date).toLocaleString()}
            <br />
            <Timer dueDate={task.due_date} />
        

        <div style={{  marginTop: '10px' }}>
            <DeleteButton 
              taskId={task.id} 
              taskTitle={task.subject} 
              deleteUrl={`/tasks/${task.id}`} 
              csrfToken={csrfToken} 
              onDeleteSuccess={handleDeleteSuccess} 
            />
        </div>
    </div>
  );
};
export default RealTimerDetail;