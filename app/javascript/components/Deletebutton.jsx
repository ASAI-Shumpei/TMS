import React from 'react';

const DeleteButton = ({ taskId, taskTitle, deleteUrl, csrfToken, onDeleteSuccess }) => { 
  
  const handleDelete = async () => {

    if (!window.confirm(`本当にタスク「${taskTitle}」を破棄しますか？`)) {
      return;
    }

    try {
      const response = await fetch(deleteUrl, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': csrfToken, 
          'Content-Type': 'application/json'
        },
      });

      if (response.ok) {
        alert("タスクを破棄しました！");
        
        if (onDeleteSuccess) {
            onDeleteSuccess(taskId); 
        }
        return;
      } else {
        const errorData = await response.json().catch(() => ({}));
        alert(`破棄に失敗しました: ${errorData.message || response.statusText}`);
      }
    } catch (error) {
      console.error('通信エラー:', error);
      alert("通信エラーが発生しました。");
    }
  };

  return (
    <button onClick={handleDelete} className="button button-delete">
      このタスクを破棄
    </button>
  );
};

export default DeleteButton;