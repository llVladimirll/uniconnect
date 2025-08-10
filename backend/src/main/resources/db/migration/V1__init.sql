CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- create users table
CREATE TABLE users (
                       id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                       name VARCHAR(100) NOT NULL,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       password_hash TEXT NOT NULL,
                       department VARCHAR(100),
                       faculty VARCHAR(100),
                       year_of_entry INT,
                       role VARCHAR(100) NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create followers table
CREATE TABLE followers (
                           follower_id UUID REFERENCES users(id) ON DELETE CASCADE,
                           following_id UUID REFERENCES users(id) ON DELETE CASCADE,
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           PRIMARY KEY (follower_id, following_id)
);

-- create posts table
CREATE TABLE posts (
                       id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                       user_id UUID REFERENCES users(id) ON DELETE CASCADE,
                       visibility VARCHAR(100) NOT NULL,
                       content TEXT NOT NULL,
                       media_url TEXT,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create likes table
CREATE TABLE post_likes (
                            id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                            post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
                            user_id UUID REFERENCES users(id) ON DELETE CASCADE,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create comments table
CREATE TABLE post_comments (
                               id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                               post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
                               user_id UUID REFERENCES users(id) ON DELETE CASCADE,
                               content TEXT NOT NULL,
                               created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create reposts table
CREATE TABLE post_reposts (
                              id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                              post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
                              user_id UUID REFERENCES users(id) ON DELETE CASCADE,
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create study groups table
CREATE TABLE study_groups (
                              id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                              name VARCHAR(100) NOT NULL,
                              description TEXT,
                              creator_id UUID REFERENCES users(id) ON DELETE CASCADE,
                              tags TEXT[],
                              is_private BOOLEAN DEFAULT false,
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create group members table
CREATE TABLE group_membership (
                                  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
                                  group_id UUID REFERENCES study_groups(id) ON DELETE CASCADE,
                                  role VARCHAR(100) DEFAULT 'member',
                                  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                  PRIMARY KEY (user_id, group_id)
);

-- create group messages table
CREATE TABLE group_messages (
                                id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                group_id UUID REFERENCES study_groups(id) ON DELETE CASCADE,
                                sender_id UUID REFERENCES users(id) ON DELETE CASCADE,
                                content TEXT NOT NULL,
                                message_type VARCHAR(100),
                                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create group live sessions table
CREATE TABLE group_live_sessions (
                                     id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                     group_id UUID REFERENCES study_groups(id) ON DELETE CASCADE,
                                     host_id UUID REFERENCES users(id) ON DELETE CASCADE,
                                     stream_url TEXT NOT NULL,
                                     started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                     ended_at TIMESTAMP,
                                     is_active BOOLEAN DEFAULT true
);

-- create group posts table
CREATE TABLE group_posts (
                             id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                             group_id UUID REFERENCES study_groups(id) ON DELETE CASCADE,
                             author_id UUID REFERENCES users(id) ON DELETE CASCADE,
                             content TEXT NOT NULL,
                             media_url TEXT,
                             created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create group files table
CREATE TABLE group_files (
                             id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                             group_id UUID REFERENCES study_groups(id) ON DELETE CASCADE,
                             uploader_id UUID REFERENCES users(id) ON DELETE CASCADE,
                             file_url TEXT NOT NULL,
                             description TEXT,
                             uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create events table
CREATE TABLE events (
                        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                        organizer_id UUID REFERENCES users(id) ON DELETE CASCADE,
                        name VARCHAR(100) NOT NULL,
                        description TEXT,
                        location VARCHAR(255),
                        is_online BOOLEAN DEFAULT false,
                        link TEXT,
                        tags TEXT[],
                        start_time TIMESTAMP NOT NULL,
                        end_time TIMESTAMP
);

-- create event participants table
CREATE TABLE event_participation (
                                     user_id UUID REFERENCES users(id) ON DELETE CASCADE,
                                     event_id UUID REFERENCES events(id) ON DELETE CASCADE,
                                     status VARCHAR(100) DEFAULT 'rsvp',
                                     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                     PRIMARY KEY (user_id, event_id)
);

-- create user interactions table
CREATE TABLE user_interactions (
                                   id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                   user_id UUID REFERENCES users(id) ON DELETE CASCADE,
                                   target_type VARCHAR(100) NOT NULL,
                                   target_id UUID NOT NULL,
                                   interaction VARCHAR(100) NOT NULL,
                                   timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);