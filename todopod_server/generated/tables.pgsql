--
-- Class Todo as table todos
--

CREATE TABLE todos (
  "id" serial,
  "title" text NOT NULL,
  "description" text NOT NULL,
  "priority" integer NOT NULL,
  "isDone" boolean NOT NULL
);

ALTER TABLE ONLY todos
  ADD CONSTRAINT todos_pkey PRIMARY KEY (id);


