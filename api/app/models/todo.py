from app.extensions import db


class Todo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(150))
    description = db.Column(db.Text)
    completed = db.Column(db.Boolean, default=False)

    def __repr__(self):
        return f'<Post "{self.title}">'
    
    def __init__(self, title, description, completed=False):
        self.title = title
        self.description = description
        self.completed = completed

    def serialize(self):
        return {
            'id': self.id,
            'title': self.title,
            'description': self.description,
            'isCompleted': self.completed,
        }
