from flask import jsonify, request

from app import db
from app.models.todo import Todo
from app.todo import bp


@bp.route('/', methods=['GET', 'POST'])
def todos():
    data = Todo.query.all()

    if request.method == 'POST':
        data = request.get_json()
        todo = Todo(
            title=data['title'], 
            description = data['description'],
            )
        db.session.add(todo)
        db.session.commit()
        return jsonify(todo.serialize(), 201)
    return jsonify([todo.serialize() for todo in data])


@bp.route('/<int:id>/', methods=['GET', 'PUT', 'DELETE'])
def get_todo(id):
    todo = Todo.query.get(id)
    if request.method == 'PUT':
        data = request.get_json()
        if not data or 'title' not in data or 'description' not in data or 'isCompleted' not in data:
            return jsonify({'error': 'Invalid request data'}), 400
        todo.title = data['title']
        todo.description = data['description']
        todo.completed = data['isCompleted']
        try:
            db.session.commit()
            return jsonify(todo.serialize()), 200
        except:
            db.session.rollback()
            return jsonify({'error': 'Failed to update Todo'}), 500
    elif request.method == 'DELETE':
        print(todo)
        db.session.delete(todo)
        db.session.commit()
        return '', 204
    else:
        return jsonify({'data': todo}, 200)
