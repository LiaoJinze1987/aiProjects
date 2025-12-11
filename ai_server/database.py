from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker, declarative_base

DATABASE_URL = "sqlite:///./app.db"
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(bind=engine, autoflush=False, expire_on_commit=False)
Base = declarative_base()

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True, nullable=False)
    email = Column(String, unique=True, index=True, nullable=False)
    password = Column(String, nullable=False)

def init_db():
    Base.metadata.create_all(bind=engine)

def create_user(username: str, email: str, password: str):
    db = SessionLocal()
    user = User(username = username, email = email, password = password)
    db.add(user)
    db.commit()
    db.refresh(user)
    db.close()

def get_user_by_username(username: str):
    db = SessionLocal()
    user = db.query(User).filter(User.username == username).first()
    db.close()
    return user

def get_user_by_email(email: str):
    db = SessionLocal()
    user = db.query(User).filter(User.email == email).first()
    db.close()
    return user

def get_user_by_id(uid: int):
    db = SessionLocal()
    user = db.query(User).filter(User.id == uid).first()
    db.close()
    return user

def update_password(email: str, new_pwd: str):
    db = SessionLocal()
    user = db.query(User).filter(User.email == email).first()
    if user:
        user.password = new_pwd
        db.commit()
        db.refresh(user)
    db.close()
    return user

def delete_user(uid: int):
    db = SessionLocal()
    user = db.query(User).filter(User.id == uid).first()
    if user:
        db.delete(user)
        db.commit()
    db.close()
    return user
