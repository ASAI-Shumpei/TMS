import React, { useState, useEffect } from 'react';

import Timer from './components/Timer';
import DeleteButton from './components/Deletebutton'; 
const RealTimer = () => {
  const [tasks, setTasks] = useState([]);
  const [csrfToken, setCsrfToken] = useState(''); 

  useEffect(() => {

    const token = document.querySelector('meta[name="csrf-token"]')
      ? document.querySelector('meta[name="csrf-token"]').content
      : '';
    setCsrfToken(token);


    fetch('/api/tasks')
      .then(response => response.json())
      .then(data => {
        setTasks(data);
      })
      .catch(error => console.error('Error fetching tasks:', error));
  }, []);


  const handleDeleteSuccess = (deletedTaskId) => {
    setTasks(prevTasks => prevTasks.filter(task => task.id !== deletedTaskId));
  };

  const handleCardClick = (taskId) => {
    sessionStorage.setItem('selectedTaskId', taskId);
    window.location.href = `/tasks/${taskId}`;
  };

  if (!csrfToken) {
    return <div>Loading or CSRF token missing...</div>; 
  }

  return (
    <div>
      {tasks.map(task => (
        <div key={task.id} className="task-card" style={{ marginBottom: '16px'}}>
          
          <div onClick={() => handleCardClick(task.id)}>
            <h3>件名: {task.subject}</h3>
            <p>詳細: {task.detail}</p>
            期限: {new Date(task.due_date).toLocaleString()}
            <br />
            <Timer dueDate={task.due_date} />
          </div>


          <div style={{ marginTop: '10px' }}>
            <DeleteButton 
              taskId={task.id} 
              taskTitle={task.subject} 
              deleteUrl={`/tasks/${task.id}`} 
              csrfToken={csrfToken} 
              onDeleteSuccess={handleDeleteSuccess} 
            />
          </div>
        </div>
      ))}
    </div>
  );
};

export default RealTimer;