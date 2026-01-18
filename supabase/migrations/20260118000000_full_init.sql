--
-- PostgreSQL database dump
--

-- garbage removed


-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
-- SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: update_communities_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_communities_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
  END;
  $$;


--
-- Name: update_community_roles_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_community_roles_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        BEGIN
          NEW.updated_at = CURRENT_TIMESTAMP;
          RETURN NEW;
        END;
        $$;


--
-- Name: update_evaluations_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_evaluations_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
  END;
  $$;


--
-- Name: update_health_records_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_health_records_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
  END;
  $$;


--
-- Name: update_sisters_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_sisters_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
  END;
  $$;


--
-- Name: update_users_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_users_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
  END;
  $$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_logs (
    id bigint NOT NULL,
    user_id integer,
    action character varying(100) NOT NULL,
    table_name character varying(100) NOT NULL,
    record_id bigint,
    old_value jsonb,
    new_value jsonb,
    ip_address character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- Name: chat_conversations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.chat_conversations (
    id integer NOT NULL,
    conversation_id uuid NOT NULL,
    user_id integer,
    user_message text NOT NULL,
    ai_response text NOT NULL,
    context_used jsonb,
    entities_extracted jsonb,
    intent character varying(50),
    tokens_used integer DEFAULT 0,
    cost numeric(10,6) DEFAULT 0,
    is_helpful boolean,
    feedback text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: chat_conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.chat_conversations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: chat_conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.chat_conversations_id_seq OWNED BY public.chat_conversations.id;


--
-- Name: communities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.communities (
    id integer NOT NULL,
    code character varying(30) NOT NULL,
    name character varying(150) NOT NULL,
    address character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    phone character varying(20),
    email character varying(100),
    established_date date,
    status character varying(20) DEFAULT 'active'::character varying,
    description text
);


--
-- Name: communities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.communities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: communities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.communities_id_seq OWNED BY public.communities.id;


--
-- Name: community_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_assignments (
    id integer NOT NULL,
    sister_id integer NOT NULL,
    community_id integer NOT NULL,
    role character varying(50) DEFAULT 'member'::character varying NOT NULL,
    start_date date NOT NULL,
    end_date date,
    decision_number character varying(50),
    decision_date date,
    decision_file_url character varying(255),
    notes text,
    CONSTRAINT community_assignments_role_check CHECK (((role)::text = ANY ((ARRAY['superior'::character varying, 'assistant'::character varying, 'vice_superior'::character varying, 'deputy'::character varying, 'secretary'::character varying, 'treasurer'::character varying, 'member'::character varying])::text[])))
);


--
-- Name: community_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.community_assignments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: community_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.community_assignments_id_seq OWNED BY public.community_assignments.id;


--
-- Name: community_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_events (
    id integer NOT NULL,
    community_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    event_date date NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: community_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.community_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: community_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.community_events_id_seq OWNED BY public.community_events.id;


--
-- Name: community_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_roles (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    display_order integer DEFAULT 0,
    color character varying(20) DEFAULT '#6c757d'::character varying,
    is_default boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: community_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.community_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: community_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.community_roles_id_seq OWNED BY public.community_roles.id;


--
-- Name: departure_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.departure_records (
    id integer NOT NULL,
    sister_id integer NOT NULL,
    departure_date date NOT NULL,
    stage_at_departure character varying(50),
    reason text,
    support_notes text,
    type character varying(50),
    expected_return_date date,
    return_date date,
    destination character varying(255),
    contact_phone character varying(50),
    contact_address text,
    approved_by integer,
    notes text,
    documents jsonb,
    CONSTRAINT departure_records_stage_at_departure_check CHECK (((stage_at_departure)::text = ANY ((ARRAY['inquiry'::character varying, 'postulant'::character varying, 'aspirant'::character varying, 'novice'::character varying, 'temporary_vows'::character varying, 'perpetual_vows'::character varying, 'left'::character varying])::text[])))
);


--
-- Name: departure_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.departure_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: departure_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.departure_records_id_seq OWNED BY public.departure_records.id;


--
-- Name: education; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.education (
    id integer NOT NULL,
    sister_id integer NOT NULL,
    level character varying(50) NOT NULL,
    major character varying(150),
    institution character varying(200),
    start_date date,
    end_date date,
    certificate_url character varying(255),
    graduation_year integer,
    status character varying(50) DEFAULT 'dang_hoc'::character varying,
    gpa character varying(20),
    thesis_title character varying(500),
    notes text,
    documents jsonb,
    CONSTRAINT education_level_check CHECK (((level)::text = ANY ((ARRAY['secondary'::character varying, 'bachelor'::character varying, 'master'::character varying, 'doctorate'::character varying])::text[]))),
    CONSTRAINT education_status_check CHECK (((status)::text = ANY ((ARRAY['dang_hoc'::character varying, 'da_tot_nghiep'::character varying, 'tam_nghi'::character varying, 'da_nghi'::character varying])::text[])))
);


--
-- Name: education_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.education_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: education_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.education_id_seq OWNED BY public.education.id;


--
-- Name: education_levels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.education_levels (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    display_order integer DEFAULT 0,
    color character varying(20) DEFAULT '#6c757d'::character varying,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: education_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.education_levels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: education_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.education_levels_id_seq OWNED BY public.education_levels.id;


--
-- Name: evaluations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.evaluations (
    id integer NOT NULL,
    sister_id integer NOT NULL,
    evaluation_period character varying(50) NOT NULL,
    evaluator_id integer,
    spiritual_life_score smallint,
    community_life_score smallint,
    mission_score smallint,
    personality_score smallint,
    obedience_score smallint,
    general_comments text,
    recommendations text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    evaluation_type character varying(50),
    period character varying(100),
    evaluation_date date,
    evaluator character varying(255),
    spiritual_life smallint,
    community_life smallint,
    apostolic_work smallint,
    personal_development smallint,
    overall_rating smallint,
    strengths text,
    weaknesses text,
    notes text,
    documents jsonb
);


--
-- Name: evaluations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.evaluations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evaluations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.evaluations_id_seq OWNED BY public.evaluations.id;


--
-- Name: health_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.health_records (
    id integer NOT NULL,
    sister_id integer NOT NULL,
    general_health character varying(50) DEFAULT 'good'::character varying NOT NULL,
    chronic_diseases text,
    work_limitations text,
    checkup_date date,
    checkup_place character varying(150),
    diagnosis text,
    treatment text,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    doctor character varying(150),
    blood_pressure character varying(20),
    heart_rate character varying(20),
    weight numeric(5,2),
    height numeric(5,2),
    next_checkup_date date,
    documents jsonb,
    CONSTRAINT health_records_general_health_check CHECK (((general_health)::text = ANY (ARRAY[('good'::character varying)::text, ('average'::character varying)::text, ('weak'::character varying)::text])))
);


--
-- Name: health_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.health_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: health_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.health_records_id_seq OWNED BY public.health_records.id;


--
-- Name: journey_stages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journey_stages (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    display_order integer DEFAULT 0,
    color character varying(20) DEFAULT '#6c757d'::character varying,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: journey_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.journey_stages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journey_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.journey_stages_id_seq OWNED BY public.journey_stages.id;


--
-- Name: missions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.missions (
    id integer NOT NULL,
    sister_id integer NOT NULL,
    field character varying(255) NOT NULL,
    specific_role character varying(150),
    start_date date NOT NULL,
    end_date date,
    notes text,
    organization character varying(200),
    address text,
    documents text
);


--
-- Name: missions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.missions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: missions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.missions_id_seq OWNED BY public.missions.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    type character varying(50) DEFAULT 'info'::character varying NOT NULL,
    title character varying(255) NOT NULL,
    message text,
    link text,
    is_read boolean DEFAULT false NOT NULL,
    read_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permissions (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    module character varying(50) NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    title character varying(500) NOT NULL,
    slug character varying(500),
    content text,
    excerpt text,
    category character varying(50) DEFAULT 'thong-bao'::character varying,
    status character varying(20) DEFAULT 'draft'::character varying,
    is_pinned boolean DEFAULT false,
    featured_image text,
    attachments jsonb DEFAULT '[]'::jsonb,
    author_id integer,
    view_count integer DEFAULT 0,
    published_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone,
    summary text,
    is_important boolean DEFAULT false,
    tags jsonb DEFAULT '[]'::jsonb
);


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    file_name text NOT NULL,
    applied_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: sister_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sister_statuses (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    display_order integer DEFAULT 0,
    color character varying(20) DEFAULT '#6c757d'::character varying,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: sister_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sister_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sister_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sister_statuses_id_seq OWNED BY public.sister_statuses.id;


--
-- Name: sisters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sisters (
    id integer NOT NULL,
    code character varying(30) NOT NULL,
    birth_name character varying(120) NOT NULL,
    date_of_birth date NOT NULL,
    place_of_birth character varying(150),
    nationality character varying(80),
    father_name character varying(120),
    mother_name character varying(120),
    family_religion character varying(80),
    baptism_date date,
    baptism_place character varying(150),
    confirmation_date date,
    first_communion_date date,
    phone character varying(30),
    email character varying(120),
    emergency_contact_name character varying(120),
    emergency_contact_phone character varying(30),
    photo_url character varying(255),
    status character varying(50) DEFAULT 'active'::character varying NOT NULL,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    saint_name character varying(120),
    permanent_address character varying(255),
    notes text,
    id_card character varying(20),
    id_card_date date,
    id_card_place character varying(150),
    current_address character varying(255),
    father_occupation character varying(100),
    mother_occupation character varying(100),
    siblings_count integer,
    family_address character varying(255),
    current_stage character varying(50),
    current_community_id integer,
    documents jsonb,
    hometown character varying(150),
    CONSTRAINT sisters_current_stage_check CHECK (((current_stage)::text = ANY (ARRAY[('inquiry'::character varying)::text, ('postulant'::character varying)::text, ('aspirant'::character varying)::text, ('novice'::character varying)::text, ('temporary_vows'::character varying)::text, ('perpetual_vows'::character varying)::text, ('left'::character varying)::text]))),
    CONSTRAINT sisters_status_check CHECK (((status)::text = ANY (ARRAY[('active'::character varying)::text, ('left'::character varying)::text])))
);


--
-- Name: COLUMN sisters.documents; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.sisters.documents IS 'JSON array of document files';


--
-- Name: sisters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sisters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sisters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sisters_id_seq OWNED BY public.sisters.id;


--
-- Name: training_courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.training_courses (
    id integer NOT NULL,
    sister_id integer NOT NULL,
    course_name character varying(180) NOT NULL,
    organizer character varying(180),
    start_date date,
    end_date date,
    content text,
    notes text
);


--
-- Name: training_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.training_courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: training_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.training_courses_id_seq OWNED BY public.training_courses.id;


--
-- Name: user_communities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_communities (
    id integer NOT NULL,
    user_id integer NOT NULL,
    community_id integer NOT NULL,
    granted_by integer,
    granted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: user_communities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_communities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_communities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_communities_id_seq OWNED BY public.user_communities.id;


--
-- Name: user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL,
    granted_by integer,
    granted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_permissions_id_seq OWNED BY public.user_permissions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(120) NOT NULL,
    role character varying(50) DEFAULT 'viewer'::character varying NOT NULL,
    last_login timestamp without time zone,
    is_active smallint DEFAULT 1 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    full_name character varying(150),
    phone character varying(30),
    avatar character varying(500),
    data_scope character varying(20) DEFAULT 'community'::character varying NOT NULL,
    CONSTRAINT users_data_scope_check CHECK (((data_scope)::text = ANY ((ARRAY['all'::character varying, 'community'::character varying, 'own'::character varying])::text[]))),
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'superior_general'::character varying, 'superior_provincial'::character varying, 'superior_community'::character varying, 'secretary'::character varying, 'viewer'::character varying])::text[])))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: vocation_journey; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vocation_journey (
    id integer NOT NULL,
    sister_id integer NOT NULL,
    stage character varying(50) NOT NULL,
    start_date date NOT NULL,
    end_date date,
    community_id integer,
    supervisor_id integer,
    notes text,
    location character varying(255),
    superior character varying(255),
    formation_director character varying(255),
    documents text,
    CONSTRAINT vocation_journey_stage_check CHECK (((stage)::text = ANY (ARRAY[('inquiry'::character varying)::text, ('postulant'::character varying)::text, ('aspirant'::character varying)::text, ('novice'::character varying)::text, ('temporary_vows'::character varying)::text, ('perpetual_vows'::character varying)::text, ('left'::character varying)::text])))
);


--
-- Name: vocation_journey_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vocation_journey_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vocation_journey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vocation_journey_id_seq OWNED BY public.vocation_journey.id;


--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- Name: chat_conversations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat_conversations ALTER COLUMN id SET DEFAULT nextval('public.chat_conversations_id_seq'::regclass);


--
-- Name: communities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communities ALTER COLUMN id SET DEFAULT nextval('public.communities_id_seq'::regclass);


--
-- Name: community_assignments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_assignments ALTER COLUMN id SET DEFAULT nextval('public.community_assignments_id_seq'::regclass);


--
-- Name: community_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_events ALTER COLUMN id SET DEFAULT nextval('public.community_events_id_seq'::regclass);


--
-- Name: community_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_roles ALTER COLUMN id SET DEFAULT nextval('public.community_roles_id_seq'::regclass);


--
-- Name: departure_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departure_records ALTER COLUMN id SET DEFAULT nextval('public.departure_records_id_seq'::regclass);


--
-- Name: education id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.education ALTER COLUMN id SET DEFAULT nextval('public.education_id_seq'::regclass);


--
-- Name: education_levels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.education_levels ALTER COLUMN id SET DEFAULT nextval('public.education_levels_id_seq'::regclass);


--
-- Name: evaluations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluations ALTER COLUMN id SET DEFAULT nextval('public.evaluations_id_seq'::regclass);


--
-- Name: health_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.health_records ALTER COLUMN id SET DEFAULT nextval('public.health_records_id_seq'::regclass);


--
-- Name: journey_stages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_stages ALTER COLUMN id SET DEFAULT nextval('public.journey_stages_id_seq'::regclass);


--
-- Name: missions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.missions ALTER COLUMN id SET DEFAULT nextval('public.missions_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: sister_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sister_statuses ALTER COLUMN id SET DEFAULT nextval('public.sister_statuses_id_seq'::regclass);


--
-- Name: sisters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sisters ALTER COLUMN id SET DEFAULT nextval('public.sisters_id_seq'::regclass);


--
-- Name: training_courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.training_courses ALTER COLUMN id SET DEFAULT nextval('public.training_courses_id_seq'::regclass);


--
-- Name: user_communities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_communities ALTER COLUMN id SET DEFAULT nextval('public.user_communities_id_seq'::regclass);


--
-- Name: user_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_permissions ALTER COLUMN id SET DEFAULT nextval('public.user_permissions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: vocation_journey id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocation_journey ALTER COLUMN id SET DEFAULT nextval('public.vocation_journey_id_seq'::regclass);


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (1, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 00:44:33.977505');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (2, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 00:44:35.398704');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (3, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheetreports", "type": "server", "message": "Not Found - /api/timesheetreports"}', '127.0.0.1', '2026-01-11 00:44:36.788898');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (4, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/social-sheets", "type": "server", "message": "Not Found - /api/social-sheets"}', '127.0.0.1', '2026-01-11 00:44:37.345198');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (5, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:14.291298');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (6, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:15.524');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (7, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:16.185901');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (8, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:16.416361');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (9, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:16.60259');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (10, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:16.776003');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (11, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:16.967102');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (12, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:17.247538');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (13, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:17.694915');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (14, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:18.030856');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (15, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:18.243148');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (16, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:18.419647');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (17, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:18.612323');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (18, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:18.792829');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (19, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:18.973158');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (20, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:11:19.164675');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (21, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/social-sheets", "type": "server", "message": "Not Found - /api/social-sheets"}', '127.0.0.1', '2026-01-11 01:11:20.687997');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (22, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheetreports", "type": "server", "message": "Not Found - /api/timesheetreports"}', '127.0.0.1', '2026-01-11 01:11:21.251403');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (23, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:24:03.172464');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (24, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheetreports", "type": "server", "message": "Not Found - /api/timesheetreports"}', '127.0.0.1', '2026-01-11 01:24:04.223501');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (25, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/social-sheets", "type": "server", "message": "Not Found - /api/social-sheets"}', '127.0.0.1', '2026-01-11 01:24:04.92477');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (26, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:38:51.461591');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (27, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:39:00.984098');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (28, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:47:39.083454');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (29, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:47:40.752004');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (30, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:51:56.335697');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (31, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:51:57.70605');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (32, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 01:53:07.676853');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (33, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 02:01:41.038128');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (34, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 07:20:27.259027');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (35, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 07:20:29.228866');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (36, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 07:32:58.706047');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (37, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 07:33:00.07525');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (38, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/social-sheets", "type": "server", "message": "Not Found - /api/social-sheets"}', '127.0.0.1', '2026-01-11 07:33:01.116969');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (39, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 07:33:01.731911');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (40, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheetreports", "type": "server", "message": "Not Found - /api/timesheetreports"}', '127.0.0.1', '2026-01-11 07:33:02.180978');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (41, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 07:37:37.11272');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (42, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/social-sheets", "type": "server", "message": "Not Found - /api/social-sheets"}', '127.0.0.1', '2026-01-11 07:37:38.202956');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (43, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/social-sheets", "type": "server", "message": "Not Found - /api/social-sheets"}', '127.0.0.1', '2026-01-11 07:37:38.62367');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (44, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/timesheets", "type": "server", "message": "Not Found - /api/timesheets"}', '127.0.0.1', '2026-01-11 07:37:48.29355');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (60, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions/module/Qu%E1%BA%A3n%20l%C3%BD%20Tu%20S%C4%A9", "type": "server", "message": "Not Found - /permissions/module/Qu%E1%BA%A3n%20l%C3%BD%20Tu%20S%C4%A9"}', '127.0.0.1', '2026-01-16 20:02:24.442447');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (61, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions", "type": "server", "message": "Not Found - /permissions"}', '127.0.0.1', '2026-01-16 20:02:24.451524');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (45, 1, 'CREATE', 'sisters', 1, NULL, '{"id": 1, "code": "TEST001", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Sister", "created_at": "2026-01-16T12:44:46.226Z", "created_by": 1, "saint_name": "Maria", "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1990-01-14T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": "Test City", "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-16 19:44:46.239455');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (46, 1, 'DELETE', 'sisters', 1, '{"id": 1, "code": "TEST001", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Sister", "created_at": "2026-01-16T12:44:46.226Z", "created_by": 1, "saint_name": "Maria", "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1990-01-14T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": "Test City", "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '{"id": 1, "code": "TEST001", "email": null, "notes": null, "phone": null, "status": "left", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Sister", "created_at": "2026-01-16T12:44:46.226Z", "created_by": 1, "saint_name": "Maria", "updated_at": "2026-01-16T12:44:46.256Z", "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1990-01-14T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": "Test City", "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-16 19:44:46.258648');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (47, 1, 'CREATE', 'sisters', 3, NULL, '{"id": 3, "code": "T001", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test", "created_at": "2026-01-16T12:46:03.768Z", "created_by": 1, "saint_name": "Maria", "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1990-01-14T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": "Test", "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-16 19:46:03.769856');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (48, 1, 'CREATE', 'sisters', 6, NULL, '{"id": 6, "code": "TEST1768567646669", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Sister", "created_at": "2026-01-16T12:47:26.679Z", "created_by": 1, "saint_name": "Maria", "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1990-01-14T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": "Test City", "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-16 19:47:26.682161');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (49, 1, 'DELETE', 'sisters', 6, '{"id": 6, "code": "TEST1768567646669", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Sister", "created_at": "2026-01-16T12:47:26.679Z", "created_by": 1, "saint_name": "Maria", "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1990-01-14T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": "Test City", "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '{"id": 6, "code": "TEST1768567646669", "email": null, "notes": null, "phone": null, "status": "left", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Sister", "created_at": "2026-01-16T12:47:26.679Z", "created_by": 1, "saint_name": "Maria", "updated_at": "2026-01-16T12:47:26.694Z", "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1990-01-14T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": "Test City", "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-16 19:47:26.697112');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (50, NULL, 'error', 'system', NULL, NULL, '{"path": "/auth/login", "type": "server", "message": "Not Found - /auth/login"}', '127.0.0.1', '2026-01-16 20:02:23.560543');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (51, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions/me", "type": "server", "message": "Not Found - /permissions/me"}', '127.0.0.1', '2026-01-16 20:02:23.628882');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (52, NULL, 'error', 'system', NULL, NULL, '{"path": "/users", "type": "server", "message": "Not Found - /users"}', '127.0.0.1', '2026-01-16 20:02:23.63897');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (53, NULL, 'error', 'system', NULL, NULL, '{"path": "/sisters", "type": "server", "message": "Not Found - /sisters"}', '127.0.0.1', '2026-01-16 20:02:23.650957');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (54, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions/check/sisters.view", "type": "server", "message": "Not Found - /permissions/check/sisters.view"}', '127.0.0.1', '2026-01-16 20:02:24.18325');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (55, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions/check/users.delete", "type": "server", "message": "Not Found - /permissions/check/users.delete"}', '127.0.0.1', '2026-01-16 20:02:24.192466');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (56, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions/check-any", "type": "server", "message": "Not Found - /permissions/check-any"}', '127.0.0.1', '2026-01-16 20:02:24.202872');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (57, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions/check-all", "type": "server", "message": "Not Found - /permissions/check-all"}', '127.0.0.1', '2026-01-16 20:02:24.215459');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (58, NULL, 'error', 'system', NULL, NULL, '{"path": "/auth/login", "type": "server", "message": "Not Found - /auth/login"}', '127.0.0.1', '2026-01-16 20:02:24.385157');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (59, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions", "type": "server", "message": "Not Found - /permissions"}', '127.0.0.1', '2026-01-16 20:02:24.433301');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (62, NULL, 'error', 'system', NULL, NULL, '{"path": "/users/null/permissions", "type": "server", "message": "Not Found - /users/null/permissions"}', '127.0.0.1', '2026-01-16 20:02:24.471041');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (63, NULL, 'error', 'system', NULL, NULL, '{"path": "/users/null/permissions", "type": "server", "message": "Not Found - /users/null/permissions"}', '127.0.0.1', '2026-01-16 20:02:24.48002');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (64, NULL, 'error', 'system', NULL, NULL, '{"path": "/auth/login", "type": "server", "message": "Not Found - /auth/login"}', '127.0.0.1', '2026-01-16 20:03:43.661557');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (65, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions/me", "type": "server", "message": "Not Found - /permissions/me"}', '127.0.0.1', '2026-01-16 20:03:43.70642');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (66, NULL, 'error', 'system', NULL, NULL, '{"path": "/users", "type": "server", "message": "Not Found - /users"}', '127.0.0.1', '2026-01-16 20:03:43.710701');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (67, NULL, 'error', 'system', NULL, NULL, '{"path": "/sisters", "type": "server", "message": "Not Found - /sisters"}', '127.0.0.1', '2026-01-16 20:03:43.714076');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (68, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions/check/sisters.view", "type": "server", "message": "Not Found - /permissions/check/sisters.view"}', '127.0.0.1', '2026-01-16 20:03:43.921073');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (69, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions/check/users.delete", "type": "server", "message": "Not Found - /permissions/check/users.delete"}', '127.0.0.1', '2026-01-16 20:03:43.925263');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (70, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions/check-any", "type": "server", "message": "Not Found - /permissions/check-any"}', '127.0.0.1', '2026-01-16 20:03:43.929962');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (71, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions/check-all", "type": "server", "message": "Not Found - /permissions/check-all"}', '127.0.0.1', '2026-01-16 20:03:43.934448');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (72, NULL, 'error', 'system', NULL, NULL, '{"path": "/auth/login", "type": "server", "message": "Not Found - /auth/login"}', '127.0.0.1', '2026-01-16 20:03:43.998801');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (73, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions", "type": "server", "message": "Not Found - /permissions"}', '127.0.0.1', '2026-01-16 20:03:44.00489');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (74, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions/module/Qu%E1%BA%A3n%20l%C3%BD%20Tu%20S%C4%A9", "type": "server", "message": "Not Found - /permissions/module/Qu%E1%BA%A3n%20l%C3%BD%20Tu%20S%C4%A9"}', '127.0.0.1', '2026-01-16 20:03:44.008799');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (75, NULL, 'error', 'system', NULL, NULL, '{"path": "/permissions", "type": "server", "message": "Not Found - /permissions"}', '127.0.0.1', '2026-01-16 20:03:44.012789');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (76, NULL, 'error', 'system', NULL, NULL, '{"path": "/users/null/permissions", "type": "server", "message": "Not Found - /users/null/permissions"}', '127.0.0.1', '2026-01-16 20:03:44.020851');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (77, NULL, 'error', 'system', NULL, NULL, '{"path": "/users/null/permissions", "type": "server", "message": "Not Found - /users/null/permissions"}', '127.0.0.1', '2026-01-16 20:03:44.024749');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (78, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/me", "type": "server", "message": "Not Found - /api/permissions/me"}', '127.0.0.1', '2026-01-16 20:05:07.828427');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (80, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check/sisters.view", "type": "server", "message": "Not Found - /api/permissions/check/sisters.view"}', '127.0.0.1', '2026-01-16 20:05:08.671427');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (81, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check/users.delete", "type": "server", "message": "Not Found - /api/permissions/check/users.delete"}', '127.0.0.1', '2026-01-16 20:05:08.680156');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (82, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check-any", "type": "server", "message": "Not Found - /api/permissions/check-any"}', '127.0.0.1', '2026-01-16 20:05:08.690267');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (83, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check-all", "type": "server", "message": "Not Found - /api/permissions/check-all"}', '127.0.0.1', '2026-01-16 20:05:08.699118');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (84, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions", "type": "server", "message": "Not Found - /api/permissions"}', '127.0.0.1', '2026-01-16 20:05:08.931542');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (85, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/module/Qu%E1%BA%A3n%20l%C3%BD%20Tu%20S%C4%A9", "type": "server", "message": "Not Found - /api/permissions/module/Qu%E1%BA%A3n%20l%C3%BD%20Tu%20S%C4%A9"}', '127.0.0.1', '2026-01-16 20:05:08.940329');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (86, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions", "type": "server", "message": "Not Found - /api/permissions"}', '127.0.0.1', '2026-01-16 20:05:08.948488');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (87, 1, 'UPDATE_PERMISSIONS', 'users', 10, NULL, '{"permissionIds": [1, 5]}', '127.0.0.1', '2026-01-16 20:05:08.978426');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (79, NULL, 'CREATE', 'sisters', 7, NULL, '{"id": 7, "code": "TEST_PERM_001", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Permission", "created_at": "2026-01-16T13:05:08.612Z", "created_by": 10, "saint_name": null, "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1999-12-31T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": null, "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-16 20:05:08.61476');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (88, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/me", "type": "server", "message": "Not Found - /api/permissions/me"}', '127.0.0.1', '2026-01-16 20:07:56.747293');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (90, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check/sisters.view", "type": "server", "message": "Not Found - /api/permissions/check/sisters.view"}', '127.0.0.1', '2026-01-16 20:07:57.41302');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (91, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check/users.delete", "type": "server", "message": "Not Found - /api/permissions/check/users.delete"}', '127.0.0.1', '2026-01-16 20:07:57.416643');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (89, NULL, 'CREATE', 'sisters', 8, NULL, '{"id": 8, "code": "TEST_PERM_001", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Permission", "created_at": "2026-01-16T13:07:57.388Z", "created_by": 11, "saint_name": null, "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1999-12-31T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": null, "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-16 20:07:57.390894');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (92, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check-any", "type": "server", "message": "Not Found - /api/permissions/check-any"}', '127.0.0.1', '2026-01-16 20:07:57.420227');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (93, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check-all", "type": "server", "message": "Not Found - /api/permissions/check-all"}', '127.0.0.1', '2026-01-16 20:07:57.4238');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (94, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions", "type": "server", "message": "Not Found - /api/permissions"}', '127.0.0.1', '2026-01-16 20:07:57.562364');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (95, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/module/Qu%E1%BA%A3n%20l%C3%BD%20Tu%20S%C4%A9", "type": "server", "message": "Not Found - /api/permissions/module/Qu%E1%BA%A3n%20l%C3%BD%20Tu%20S%C4%A9"}', '127.0.0.1', '2026-01-16 20:07:57.56539');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (96, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions", "type": "server", "message": "Not Found - /api/permissions"}', '127.0.0.1', '2026-01-16 20:07:57.568872');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (97, 1, 'UPDATE_PERMISSIONS', 'users', 11, NULL, '{"permissionIds": [1, 5]}', '127.0.0.1', '2026-01-16 20:07:57.578412');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (98, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/me", "type": "server", "message": "Not Found - /api/permissions/me"}', '127.0.0.1', '2026-01-16 20:09:03.456915');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (100, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check/sisters.view", "type": "server", "message": "Not Found - /api/permissions/check/sisters.view"}', '127.0.0.1', '2026-01-16 20:09:04.10634');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (101, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check/users.delete", "type": "server", "message": "Not Found - /api/permissions/check/users.delete"}', '127.0.0.1', '2026-01-16 20:09:04.109798');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (102, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check-any", "type": "server", "message": "Not Found - /api/permissions/check-any"}', '127.0.0.1', '2026-01-16 20:09:04.112934');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (103, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check-all", "type": "server", "message": "Not Found - /api/permissions/check-all"}', '127.0.0.1', '2026-01-16 20:09:04.116851');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (104, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions", "type": "server", "message": "Not Found - /api/permissions"}', '127.0.0.1', '2026-01-16 20:09:04.282144');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (105, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/module/Qu%E1%BA%A3n%20l%C3%BD%20Tu%20S%C4%A9", "type": "server", "message": "Not Found - /api/permissions/module/Qu%E1%BA%A3n%20l%C3%BD%20Tu%20S%C4%A9"}', '127.0.0.1', '2026-01-16 20:09:04.285615');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (106, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions", "type": "server", "message": "Not Found - /api/permissions"}', '127.0.0.1', '2026-01-16 20:09:04.289494');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (107, 1, 'UPDATE_PERMISSIONS', 'users', 12, NULL, '{"permissionIds": [1, 5]}', '127.0.0.1', '2026-01-16 20:09:04.302176');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (99, NULL, 'CREATE', 'sisters', 9, NULL, '{"id": 9, "code": "TEST_PERM_001", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Permission", "created_at": "2026-01-16T13:09:04.085Z", "created_by": 12, "saint_name": null, "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1999-12-31T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": null, "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-16 20:09:04.087122');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (108, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions", "type": "server", "message": "Not Found - /api/permissions"}', '127.0.0.1', '2026-01-16 20:09:13.302909');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (109, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/me", "type": "server", "message": "Not Found - /api/permissions/me"}', '127.0.0.1', '2026-01-16 20:09:53.667371');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (111, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check/sisters.view", "type": "server", "message": "Not Found - /api/permissions/check/sisters.view"}', '127.0.0.1', '2026-01-16 20:09:54.237764');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (112, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check/users.delete", "type": "server", "message": "Not Found - /api/permissions/check/users.delete"}', '127.0.0.1', '2026-01-16 20:09:54.241243');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (113, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check-any", "type": "server", "message": "Not Found - /api/permissions/check-any"}', '127.0.0.1', '2026-01-16 20:09:54.245192');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (114, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/check-all", "type": "server", "message": "Not Found - /api/permissions/check-all"}', '127.0.0.1', '2026-01-16 20:09:54.248989');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (115, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions", "type": "server", "message": "Not Found - /api/permissions"}', '127.0.0.1', '2026-01-16 20:09:54.421665');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (116, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions/module/Qu%E1%BA%A3n%20l%C3%BD%20Tu%20S%C4%A9", "type": "server", "message": "Not Found - /api/permissions/module/Qu%E1%BA%A3n%20l%C3%BD%20Tu%20S%C4%A9"}', '127.0.0.1', '2026-01-16 20:09:54.425081');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (117, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions", "type": "server", "message": "Not Found - /api/permissions"}', '127.0.0.1', '2026-01-16 20:09:54.428132');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (118, 1, 'UPDATE_PERMISSIONS', 'users', 13, NULL, '{"permissionIds": [1, 5]}', '127.0.0.1', '2026-01-16 20:09:54.438443');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (110, NULL, 'CREATE', 'sisters', 10, NULL, '{"id": 10, "code": "TEST_PERM_001", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Permission", "created_at": "2026-01-16T13:09:54.215Z", "created_by": 13, "saint_name": null, "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1999-12-31T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": null, "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-16 20:09:54.217298');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (119, NULL, 'error', 'system', NULL, NULL, '{"path": "/api/permissions", "type": "server", "message": "Not Found - /api/permissions"}', '127.0.0.1', '2026-01-16 20:10:00.561626');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (121, 1, 'UPDATE_PERMISSIONS', 'users', 14, NULL, '{"permissionIds": [1, 5]}', '127.0.0.1', '2026-01-16 20:10:28.879212');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (120, NULL, 'CREATE', 'sisters', 11, NULL, '{"id": 11, "code": "TEST_PERM_001", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Permission", "created_at": "2026-01-16T13:10:28.630Z", "created_by": 14, "saint_name": null, "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1999-12-31T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": null, "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-16 20:10:28.633911');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (123, 1, 'UPDATE_PERMISSIONS', 'users', 15, NULL, '{"permissionIds": [1, 5]}', '127.0.0.1', '2026-01-16 20:11:16.377966');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (122, NULL, 'CREATE', 'sisters', 12, NULL, '{"id": 12, "code": "TEST_PERM_001", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Permission", "created_at": "2026-01-16T13:11:16.195Z", "created_by": 15, "saint_name": null, "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1999-12-31T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": null, "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-16 20:11:16.197628');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (125, 1, 'UPDATE_PERMISSIONS', 'users', 17, NULL, '{"permissionIds": [1, 5]}', '127.0.0.1', '2026-01-16 20:11:57.582697');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (124, NULL, 'CREATE', 'sisters', 13, NULL, '{"id": 13, "code": "TEST_PERM_001", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Permission", "created_at": "2026-01-16T13:11:57.315Z", "created_by": 17, "saint_name": null, "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1999-12-31T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": null, "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-16 20:11:57.317947');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (126, 1, 'UPDATE_PERMISSIONS', 'users', 18, NULL, '{"permissionIds": [85, 86, 2, 3, 5, 40, 34]}', '127.0.0.1', '2026-01-16 20:24:30.126055');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (127, 1, 'UPDATE_PERMISSIONS', 'users', 19, NULL, '{"permissionIds": [85, 40]}', '127.0.0.1', '2026-01-16 20:24:30.151456');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (129, 1, 'UPDATE_PERMISSIONS', 'users', 19, NULL, '{"permissionIds": [40]}', '127.0.0.1', '2026-01-16 20:24:30.822726');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (130, 1, 'UPDATE_PERMISSIONS', 'users', 19, NULL, '{"permissionIds": [2, 3, 4, 5, 6, 34, 40, 85]}', '127.0.0.1', '2026-01-16 20:24:30.979243');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (131, 1, 'CREATE', 'communities', 11, NULL, '{"id": 11, "code": "ADMIN_TEST_COMM", "name": "Admin Test Community", "email": null, "phone": null, "status": "active", "address": null, "created_at": "2026-01-16T13:24:31.116Z", "updated_at": null, "description": null, "established_date": null}', '127.0.0.1', '2026-01-16 20:24:31.11915');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (128, NULL, 'CREATE', 'sisters', 14, NULL, '{"id": 14, "code": "TEST_FULL_001", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test Full User", "created_at": "2026-01-16T13:24:30.551Z", "created_by": 18, "saint_name": null, "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1989-12-31T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": null, "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-16 20:24:30.590666');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (132, 1, 'CREATE', 'communities', 12, NULL, '{"id": 12, "code": "CD035", "name": "Cộng Đoàn Mary Tây Sài Gòn", "email": "congdoan@gmail.com", "phone": "0934825671", "status": "active", "address": "123 Đường Sư Vạn Hạnh, Phường 13, Quận 10, TP. Hồ Chí Minh", "created_at": "2026-01-16T14:00:38.305Z", "updated_at": null, "description": "Cộng đoàn Thánh Âm Thanh Mary là tổ chức tôn giáo được thành lập năm 2015 tại quận 10, TP. Hồ Chí Minh. Cộng đoàn có sứ mạng tuyên truyền đức tin, phát triển cộng đoàn tín hữu và thực hiện các hoạt động từ thiện, từ ái cho cộng đồng địa phương. Hiện tại cộng đoàn đang hoạt động bình thường với 150 thành viên.", "established_date": "2015-08-14T17:00:00.000Z"}', '127.0.0.1', '2026-01-16 21:00:38.344937');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (133, 1, 'CREATE', 'communities', 13, NULL, '{"id": 13, "code": "CD1768584960481", "name": "Cộng Đoàn Demo OSP - Thành phố Hồ Chí Minh", "email": "congdoan.demo@ospvietnam.org", "phone": "0284 390 2025", "status": "active", "address": "468 An Lợi Đông, Quận 2, Thành phố Hồ Chí Minh", "created_at": "2026-01-16T17:36:00.491Z", "updated_at": null, "description": "Cộng Đoàn Demo là một tổ chức tín ngưỡng có sứ mạng truyền giáo và phục vụ cộng đồng. Cộng Đoàn tập trung vào việc phát triển tinh thần đức tin, xây dựng cộng đồng mạnh mẽ và nuôi dạy những người lãnh đạo tâm linh. Chúng tôi thực hiện các hoạt động từ thiện, giáo dục tôn giáo, và hỗ trợ xã hội cho những người cần giúp đỡ.", "established_date": "2024-01-14T17:00:00.000Z"}', '127.0.0.1', '2026-01-17 00:36:00.501822');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (134, 1, 'DELETE', 'communities', 13, '{"id": 13, "code": "CD1768584960481", "name": "Cộng Đoàn Demo OSP - Thành phố Hồ Chí Minh", "email": "congdoan.demo@ospvietnam.org", "phone": "0284 390 2025", "status": "active", "address": "468 An Lợi Đông, Quận 2, Thành phố Hồ Chí Minh", "created_at": "2026-01-16T17:36:00.491Z", "updated_at": null, "description": "Cộng Đoàn Demo là một tổ chức tín ngưỡng có sứ mạng truyền giáo và phục vụ cộng đồng. Cộng Đoàn tập trung vào việc phát triển tinh thần đức tin, xây dựng cộng đồng mạnh mẽ và nuôi dạy những người lãnh đạo tâm linh. Chúng tôi thực hiện các hoạt động từ thiện, giáo dục tôn giáo, và hỗ trợ xã hội cho những người cần giúp đỡ.", "established_date": "2024-01-14T17:00:00.000Z"}', NULL, '127.0.0.1', '2026-01-17 00:36:24.688064');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (135, 1, 'CREATE', 'communities', 14, NULL, '{"id": 14, "code": "CD1768585165334", "name": "Cộng Đoàn Đà Lạt", "email": "congdoan.dalat@ospvietnam.org", "phone": "0263 351 2668", "status": "active", "address": "125 Phù Đổng Thiên Vương, Thành phố Đà Lạt, Lâm Đồng", "created_at": "2026-01-16T17:39:25.336Z", "updated_at": null, "description": "Cộng Đoàn Đà Lạt là một cộng đoàn tâm linh nằm ở thành phố Đà Lạt, Lâm Đồng, với sứ mạng chính là truyền giáo và phục vụ cộng đồng địa phương. Cộng Đoàn hoạt động trong lĩnh vực giáo dục tôn giáo, từ thiện xã hội, và nuôi dạy các tín đồ. Chúng tôi cam kết xây dựng một cộng đồng mạnh mẽ dựa trên các giá trị tâm linh và đạo đức.", "established_date": "2020-03-09T17:00:00.000Z"}', '127.0.0.1', '2026-01-17 00:39:25.375566');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (136, 1, 'DELETE', 'communities', 14, '{"id": 14, "code": "CD1768585165334", "name": "Cộng Đoàn Đà Lạt", "email": "congdoan.dalat@ospvietnam.org", "phone": "0263 351 2668", "status": "active", "address": "125 Phù Đổng Thiên Vương, Thành phố Đà Lạt, Lâm Đồng", "created_at": "2026-01-16T17:39:25.336Z", "updated_at": null, "description": "Cộng Đoàn Đà Lạt là một cộng đoàn tâm linh nằm ở thành phố Đà Lạt, Lâm Đồng, với sứ mạng chính là truyền giáo và phục vụ cộng đồng địa phương. Cộng Đoàn hoạt động trong lĩnh vực giáo dục tôn giáo, từ thiện xã hội, và nuôi dạy các tín đồ. Chúng tôi cam kết xây dựng một cộng đồng mạnh mẽ dựa trên các giá trị tâm linh và đạo đức.", "established_date": "2020-03-09T17:00:00.000Z"}', NULL, '127.0.0.1', '2026-01-17 00:39:46.843516');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (137, 1, 'CREATE', 'communities', 15, NULL, '{"id": 15, "code": "CD1768585249936", "name": "Cộng Đoàn Mẫu Đà Lạt", "email": "template.dalat@ospvietnam.org", "phone": "0263 382 1234", "status": "active", "address": "250 Trần Phú, Thành phố Đà Lạt, Lâm Đồng", "created_at": "2026-01-16T17:40:49.941Z", "updated_at": null, "description": "Cộng Đoàn Mẫu Đà Lạt là mẫu tiêu chuẩn cho các cộng đoàn ở Đà Lạt. Được thiết kế để cung cấp một cấu trúc tổ chức hiệu quả, đây là cộng đoàn có các chức năng đầy đủ để truyền giáo, giáo dục tôn giáo và hỗ trợ cộng đồng. Mẫu này tuân theo các nguyên tắc quản lý tâm linh và được sử dụng như một tài liệu tham khảo cho các hoạt động cộng đoàn.", "established_date": "2018-12-31T17:00:00.000Z"}', '127.0.0.1', '2026-01-17 00:40:49.945981');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (138, 1, 'CREATE', 'communities', 16, NULL, '{"id": 16, "code": "CD1768585344732", "name": "Cộng Đoàn Hà Nội", "email": "congdoan.hanoi@ospvietnam.org", "phone": "0243 825 8456", "status": "active", "address": "72 Hàng Ngang, Quận Hoàn Kiếm, Thành phố Hà Nội", "created_at": "2026-01-16T17:42:24.735Z", "updated_at": null, "description": "Cộng Đoàn Hà Nội là một tổ chức tâm linh quan trọng nằm ở thủ đô Hà Nội. Được thành lập với sứ mạng truyền giáo và phục vụ cộng đồng, Cộng Đoàn Hà Nội hoạt động trong các lĩnh vực giáo dục tôn giáo, từ thiện xã hội và nuôi dạy các tín đồ. Cộng Đoàn cam kết xây dựng một cộng đồng mạnh mẽ, duy trì các giá trị tâm linh truyền thống và phục vụ nhân dân Hà Nội.", "established_date": "2018-05-04T17:00:00.000Z"}', '127.0.0.1', '2026-01-17 00:42:24.776334');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (139, 1, 'DELETE', 'sisters', 3, '{"id": 3, "code": "T001", "email": null, "notes": null, "phone": null, "status": "active", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test", "created_at": "2026-01-16T12:46:03.768Z", "created_by": 1, "saint_name": "Maria", "updated_at": null, "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1990-01-14T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": "Test", "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '{"id": 3, "code": "T001", "email": null, "notes": null, "phone": null, "status": "left", "id_card": null, "documents": null, "photo_url": null, "birth_name": "Test", "created_at": "2026-01-16T12:46:03.768Z", "created_by": 1, "saint_name": "Maria", "updated_at": "2026-01-16T17:42:54.546Z", "father_name": null, "mother_name": null, "nationality": null, "baptism_date": null, "id_card_date": null, "baptism_place": null, "current_stage": null, "date_of_birth": "1990-01-14T17:00:00.000Z", "id_card_place": null, "family_address": null, "place_of_birth": "Test", "siblings_count": null, "current_address": null, "family_religion": null, "confirmation_date": null, "father_occupation": null, "mother_occupation": null, "permanent_address": null, "current_community_id": null, "first_communion_date": null, "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-17 00:42:54.614259');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (140, 1, 'CREATE', 'sisters', 15, NULL, '{"id": 15, "code": "NT-001", "email": "minhthuan.teresa@ospvietnam.org", "notes": "Nữ tu có bến nhân trong đức tin và sự tận tâm trong công việc. Tình cảm yêu thường sâu sắc, sẵn sàng phục vụ và cư thương những người kém may mắn. Đặc biệt quan tâm đến người cũ tuổi và thanh niên.", "phone": "0987654321", "status": "active", "id_card": "234567891234", "hometown": "Thái Bình", "documents": null, "photo_url": "", "birth_name": "Vũ Thị Minh Thọn", "created_at": "2026-01-16T18:01:33.615Z", "created_by": 1, "saint_name": "Thérèse", "updated_at": null, "father_name": "Vũ Văn Hợp", "mother_name": "Trần Thị Thường", "nationality": "Việt Nam", "baptism_date": "1998-08-27T17:00:00.000Z", "id_card_date": "2021-03-07T17:00:00.000Z", "baptism_place": "Nhà thờ Thái Bình", "current_stage": null, "date_of_birth": "1998-07-21T17:00:00.000Z", "id_card_place": "Thái Bình", "family_address": null, "place_of_birth": "Thái Bình", "siblings_count": 1, "current_address": "45 Trạn Quốc Thừng, Thái Bình", "family_religion": "Công giáo", "confirmation_date": "2012-04-14T17:00:00.000Z", "father_occupation": "Nông dân", "mother_occupation": "Nông dân", "permanent_address": "45 Trạn Quốc Thừng, Thái Bình", "current_community_id": null, "first_communion_date": "2014-05-17T17:00:00.000Z", "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-17 01:01:33.655367');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (141, 1, 'CREATE', 'sisters', 16, NULL, '{"id": 16, "code": "NT-002", "email": "mylinh@example.com", "notes": "Nư tu mịa y chí sự phục vụ của Đạo. Nhu cầu phát triển bản thân và còn người quá quý với mề. Đã tham gia các hoạt động đời sống tập thể và có tăng Đạo sãu sắc.", "phone": "0987654321", "status": "active", "id_card": "0123456789123", "hometown": "Hà Tĩ", "documents": null, "photo_url": "", "birth_name": "Trần Thị Mỹ Linh", "created_at": "2026-01-16T18:01:47.140Z", "created_by": 1, "saint_name": "Maria", "updated_at": null, "father_name": "Trần Văn Hũng", "mother_name": "Trần Thị Hạnh", "nationality": "Việt Nam", "baptism_date": "1990-04-04T17:00:00.000Z", "id_card_date": "2018-01-09T17:00:00.000Z", "baptism_place": "Nhà thờ Hà Nội", "current_stage": null, "date_of_birth": "1990-03-14T17:00:00.000Z", "id_card_place": "Công an Hà Nội", "family_address": "Xã An Hẻ, Hưyện Quốc Oai, Hà Nội", "place_of_birth": "Hà Nội", "siblings_count": 3, "current_address": "456 Đường Nguyễn Huệ, TP.HCM", "family_religion": "Công Giáo", "confirmation_date": "2005-05-14T17:00:00.000Z", "father_occupation": "Nông dân", "mother_occupation": "Nông dân", "permanent_address": "123 Đường LẾ Thanh Tôn, Hà Nội", "current_community_id": null, "first_communion_date": "2010-06-19T17:00:00.000Z", "emergency_contact_name": "Trần Thị Lý", "emergency_contact_phone": "0912345678"}', '127.0.0.1', '2026-01-17 01:01:47.181205');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (142, 1, 'CREATE', 'users', 20, NULL, '{"id": 20, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0398876828", "avatar": null, "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:35:36.787Z", "data_scope": "community", "last_login": null, "updated_at": null}', '127.0.0.1', '2026-01-17 07:35:36.799857');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (143, 1, 'DELETE', 'users', 20, '{"id": 20, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0398876828", "avatar": null, "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:35:36.787Z", "data_scope": "community", "last_login": null, "updated_at": null}', NULL, '127.0.0.1', '2026-01-17 07:40:38.315284');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (144, 1, 'CREATE', 'users', 21, NULL, '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": null, "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": null, "updated_at": null}', '127.0.0.1', '2026-01-17 07:41:41.319678');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (145, 1, 'CREATE', 'users', 22, NULL, '{"id": 22, "role": "viewer", "email": "adminhanoi@gmail.com", "phone": "02939393939", "avatar": null, "username": "adminhanoi", "full_name": "Admin Hà Nội", "is_active": 1, "created_at": "2026-01-17T00:45:01.925Z", "data_scope": "community", "last_login": null, "updated_at": null}', '127.0.0.1', '2026-01-17 07:45:01.962811');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (146, 1, 'UPDATE_PERMISSIONS', 'users', 22, NULL, '{"permissionIds": []}', '127.0.0.1', '2026-01-17 07:45:01.98302');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (147, 1, 'ASSIGN_COMMUNITIES', 'users', 22, NULL, '{"community_ids": []}', '127.0.0.1', '2026-01-17 07:45:02.004257');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (148, 1, 'CREATE', 'vocation_journey', 1, NULL, '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[]", "sister_id": 16, "start_date": "1993-02-22T17:00:00.000Z", "community_id": 16, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '127.0.0.1', '2026-01-17 08:13:02.028682');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (149, 1, 'CREATE', 'vocation_journey', 2, NULL, '{"id": 2, "notes": null, "stage": "postulant", "end_date": null, "location": "Nhà Dòng Đà Lạt, Lâm Đồng", "superior": "16_Maria Trần Thị Mỹ Linh", "documents": "[]", "sister_id": 15, "start_date": "2024-12-18T17:00:00.000Z", "community_id": 15, "supervisor_id": null, "formation_director": "16_Maria Trần Thị Mỹ Linh"}', '127.0.0.1', '2026-01-17 08:14:25.203521');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (150, 1, 'UPDATE', 'vocation_journey', 2, '{"id": 2, "notes": null, "stage": "postulant", "end_date": null, "location": "Nhà Dòng Đà Lạt, Lâm Đồng", "superior": "16_Maria Trần Thị Mỹ Linh", "documents": "[]", "sister_id": 15, "start_date": "2024-12-18T17:00:00.000Z", "community_id": 15, "supervisor_id": null, "formation_director": "16_Maria Trần Thị Mỹ Linh"}', '{"id": 2, "notes": null, "stage": "postulant", "end_date": null, "location": "Nhà Dòng Đà Lạt, Lâm Đồng", "superior": "16_Maria Trần Thị Mỹ Linh", "documents": "[]", "sister_id": 15, "start_date": "2024-12-17T17:00:00.000Z", "community_id": 15, "supervisor_id": null, "formation_director": "16_Maria Trần Thị Mỹ Linh"}', '127.0.0.1', '2026-01-17 08:15:54.22254');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (151, NULL, 'error', 'system', NULL, NULL, '{"path": "/favicon.ico", "type": "server", "message": "Not Found - /favicon.ico"}', '127.0.0.1', '2026-01-17 08:19:23.221156');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (152, 1, 'UPDATE', 'vocation_journey', 2, '{"id": 2, "notes": null, "stage": "postulant", "end_date": null, "location": "Nhà Dòng Đà Lạt, Lâm Đồng", "superior": "16_Maria Trần Thị Mỹ Linh", "documents": "[]", "sister_id": 15, "start_date": "2024-12-17T17:00:00.000Z", "community_id": 15, "supervisor_id": null, "formation_director": "16_Maria Trần Thị Mỹ Linh"}', '{"id": 2, "notes": null, "stage": "postulant", "end_date": null, "location": "Nhà Dòng Đà Lạt, Lâm Đồng", "superior": "16_Maria Trần Thị Mỹ Linh", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612756259-446856523.pdf\",\"name\":\"Giay chung sinh.pdf\",\"size\":235959,\"uploaded_at\":\"2026-01-17T01:19:16.267Z\"}]", "sister_id": 15, "start_date": "2024-12-16T17:00:00.000Z", "community_id": 15, "supervisor_id": null, "formation_director": "16_Maria Trần Thị Mỹ Linh"}', '127.0.0.1', '2026-01-17 08:19:36.929532');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (153, 1, 'UPDATE', 'vocation_journey', 1, '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[]", "sister_id": 16, "start_date": "1993-02-22T17:00:00.000Z", "community_id": 16, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg\",\"name\":\"d5d020e528eea2b0fbff2.jpg\",\"size\":9340,\"uploaded_at\":\"2026-01-17T01:20:26.604Z\"}]", "sister_id": 16, "start_date": "1993-02-21T17:00:00.000Z", "community_id": 16, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '127.0.0.1', '2026-01-17 08:20:30.026596');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (169, 1, 'UPDATE', 'users', 21, '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:44:22.013Z"}', '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:44:52.563Z"}', '127.0.0.1', '2026-01-17 08:44:52.565122');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (154, 1, 'CREATE', 'education', 1, NULL, '{"id": 1, "gpa": "3.75/4.0", "level": "master", "major": "Thần học và Triết học", "notes": "Hoàn thành xuất sắc chương trình Thạc sĩ với luận văn nghiên cứu về vai trò của Giáo hội trong xã hội đương đại.", "status": "da_tot_nghiep", "end_date": "2024-06-29T17:00:00.000Z", "documents": [{"id": 1768613445218, "url": "http://localhost:5000/uploads/documents/1768613445216-806870501.jpg", "name": "d5d020e528eea2b0fbff2.jpg", "size": 9340, "type": "image/jpeg", "uploadedAt": "2026-01-17T01:30:45.218Z"}], "sister_id": 16, "start_date": "2022-08-31T17:00:00.000Z", "institution": "Đại học Khoa học Xã hội và Nhân văn TP.HCM", "thesis_title": null, "certificate_url": null, "graduation_year": 2024}', '127.0.0.1', '2026-01-17 08:30:48.013213');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (155, 1, 'CREATE', 'education', 2, NULL, '{"id": 2, "gpa": "3.75/4.0", "level": "bachelor", "major": "Thần học và Giáo lý", "notes": "Nữ tu Vũ Thị Minh Thọn đang theo học ngành Thần học và Giáo lý tại ĐH Khoa học Xã hội và Nhân văn TP.HCM. Kết quả học tập tốt với GPA 3.75/4.0. Dự kiến tốt nghiệp năm 2026.", "status": "dang_hoc", "end_date": "2024-05-31T17:00:00.000Z", "documents": [{"id": 1768613455415, "url": "http://localhost:5000/uploads/documents/1768613455414-712649413.pdf", "name": "Giay chung sinh.pdf", "size": 235959, "type": "application/pdf", "uploadedAt": "2026-01-17T01:30:55.415Z"}], "sister_id": 15, "start_date": "2022-08-31T17:00:00.000Z", "institution": "Đại học Khoa học Xã hội và Nhân văn TP.HCM", "thesis_title": "Vai trò của Giáo lý trong việc hình thành đức tin của người trẻ Công giáo Việt Nam", "certificate_url": null, "graduation_year": 2026}', '127.0.0.1', '2026-01-17 08:31:13.987622');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (156, 1, 'UPDATE', 'users', 21, '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": null, "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:22:28.393Z"}', '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:38:23.068Z"}', '127.0.0.1', '2026-01-17 08:38:23.073538');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (157, 1, 'UPDATE_PERMISSIONS', 'users', 21, NULL, '{"permissionIds": [40, 82, 84, 83, 81]}', '127.0.0.1', '2026-01-17 08:38:23.090314');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (158, 1, 'UPDATE', 'users', 21, '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:38:23.068Z"}', '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:38:43.388Z"}', '127.0.0.1', '2026-01-17 08:38:43.392101');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (159, 1, 'UPDATE_PERMISSIONS', 'users', 21, NULL, '{"permissionIds": [40, 81, 82, 83, 84]}', '127.0.0.1', '2026-01-17 08:38:43.40751');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (160, 1, 'UPDATE', 'users', 21, '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:38:43.388Z"}', '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:43:05.587Z"}', '127.0.0.1', '2026-01-17 08:43:05.592423');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (161, 1, 'UPDATE_PERMISSIONS', 'users', 21, NULL, '{"permissionIds": [40, 81, 82, 83, 84]}', '127.0.0.1', '2026-01-17 08:43:05.606281');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (162, 1, 'ASSIGN_COMMUNITIES', 'users', 21, NULL, '{"community_ids": [15]}', '127.0.0.1', '2026-01-17 08:43:05.61798');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (163, 1, 'UPDATE', 'users', 21, '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:43:05.587Z"}', '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:43:36.921Z"}', '127.0.0.1', '2026-01-17 08:43:36.925245');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (164, 1, 'UPDATE_PERMISSIONS', 'users', 21, NULL, '{"permissionIds": [40, 81, 82, 83, 84, 2, 4, 87, 3, 88, 89, 1, 86, 85]}', '127.0.0.1', '2026-01-17 08:43:36.945636');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (165, 1, 'ASSIGN_COMMUNITIES', 'users', 21, NULL, '{"community_ids": [15]}', '127.0.0.1', '2026-01-17 08:43:36.954994');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (166, 1, 'UPDATE', 'users', 21, '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:43:36.921Z"}', '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:44:22.013Z"}', '127.0.0.1', '2026-01-17 08:44:22.014499');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (167, 1, 'UPDATE_PERMISSIONS', 'users', 21, NULL, '{"permissionIds": [1, 2, 3, 4, 40, 81, 82, 83, 84, 85, 86, 87, 88, 89, 6, 8, 7, 5]}', '127.0.0.1', '2026-01-17 08:44:22.031982');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (168, 1, 'ASSIGN_COMMUNITIES', 'users', 21, NULL, '{"community_ids": [15]}', '127.0.0.1', '2026-01-17 08:44:22.042036');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (170, 1, 'UPDATE_PERMISSIONS', 'users', 21, NULL, '{"permissionIds": [5, 6, 7, 8, 40, 81, 82, 83, 84, 86, 1, 85]}', '127.0.0.1', '2026-01-17 08:44:52.582547');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (171, 1, 'ASSIGN_COMMUNITIES', 'users', 21, NULL, '{"community_ids": [15]}', '127.0.0.1', '2026-01-17 08:44:52.593159');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (172, 1, 'UPDATE', 'users', 21, '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:44:52.563Z"}', '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:45:29.159Z"}', '127.0.0.1', '2026-01-17 08:45:29.163077');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (173, 1, 'UPDATE_PERMISSIONS', 'users', 21, NULL, '{"permissionIds": [1, 5, 6, 7, 8, 40, 81, 82, 83, 84, 85, 86, 87]}', '127.0.0.1', '2026-01-17 08:45:29.178324');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (174, 1, 'ASSIGN_COMMUNITIES', 'users', 21, NULL, '{"community_ids": [15]}', '127.0.0.1', '2026-01-17 08:45:29.187641');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (175, 21, 'UPDATE', 'sisters', 15, '{"id": 15, "code": "NT-001", "email": "minhthuan.teresa@ospvietnam.org", "notes": "Nữ tu có bến nhân trong đức tin và sự tận tâm trong công việc. Tình cảm yêu thường sâu sắc, sẵn sàng phục vụ và cư thương những người kém may mắn. Đặc biệt quan tâm đến người cũ tuổi và thanh niên.", "phone": "0987654321", "status": "active", "id_card": "234567891234", "hometown": "Thái Bình", "documents": null, "photo_url": "", "birth_name": "Vũ Thị Minh Thọn", "created_at": "2026-01-16T18:01:33.615Z", "created_by": 1, "saint_name": "Thérèse", "updated_at": null, "father_name": "Vũ Văn Hợp", "mother_name": "Trần Thị Thường", "nationality": "Việt Nam", "baptism_date": "1998-08-27T17:00:00.000Z", "id_card_date": "2021-03-07T17:00:00.000Z", "baptism_place": "Nhà thờ Thái Bình", "current_stage": null, "date_of_birth": "1998-07-21T17:00:00.000Z", "id_card_place": "Thái Bình", "family_address": null, "place_of_birth": "Thái Bình", "siblings_count": 1, "current_address": "45 Trạn Quốc Thừng, Thái Bình", "family_religion": "Công giáo", "confirmation_date": "2012-04-14T17:00:00.000Z", "father_occupation": "Nông dân", "mother_occupation": "Nông dân", "permanent_address": "45 Trạn Quốc Thừng, Thái Bình", "current_community_id": null, "first_communion_date": "2014-05-17T17:00:00.000Z", "emergency_contact_name": null, "emergency_contact_phone": null}', '{"id": 15, "code": "NT-001", "email": "minhthuan.teresa@ospvietnam.org", "notes": "Nữ tu có bến nhân trong đức tin và sự tận tâm trong công việc. Tình cảm yêu thường sâu sắc, sẵn sàng phục vụ và cư thương những người kém may mắn. Đặc biệt quan tâm đến người cũ tuổi và thanh niên.", "phone": "0987654321", "status": "active", "id_card": "234567891234", "hometown": "Thái Bình", "documents": null, "photo_url": "", "birth_name": "Vũ Thị Minh Thy", "created_at": "2026-01-16T18:01:33.615Z", "created_by": 1, "saint_name": "Thérèse", "updated_at": "2026-01-17T01:45:36.118Z", "father_name": "Vũ Văn Hợp", "mother_name": "Trần Thị Thường", "nationality": "Việt Nam", "baptism_date": "1998-08-26T17:00:00.000Z", "id_card_date": "2021-03-06T17:00:00.000Z", "baptism_place": "Nhà thờ Thái Bình", "current_stage": null, "date_of_birth": "1998-07-20T17:00:00.000Z", "id_card_place": "Thái Bình", "family_address": null, "place_of_birth": "Thái Bình", "siblings_count": 1, "current_address": "45 Trạn Quốc Thừng, Thái Bình", "family_religion": "Công giáo", "confirmation_date": "2012-04-13T17:00:00.000Z", "father_occupation": "Nông dân", "mother_occupation": "Nông dân", "permanent_address": "45 Trạn Quốc Thừng, Thái Bình", "current_community_id": null, "first_communion_date": "2014-05-16T17:00:00.000Z", "emergency_contact_name": null, "emergency_contact_phone": null}', '127.0.0.1', '2026-01-17 08:45:36.131637');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (176, 1, 'TOGGLE_STATUS', 'users', 21, '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:45:29.159Z"}', '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 0, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:47:57.735Z"}', '127.0.0.1', '2026-01-17 08:47:57.748735');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (177, 1, 'TOGGLE_STATUS', 'users', 21, '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 0, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:47:57.735Z"}', '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T01:22:28.391Z", "updated_at": "2026-01-17T01:48:17.499Z"}', '127.0.0.1', '2026-01-17 08:48:17.512787');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (178, 1, 'ADD_EVENT', 'communities', 16, NULL, '{"id": 1, "title": "Lễ bổn mạng"}', '127.0.0.1', '2026-01-17 09:05:16.640126');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (179, 1, 'ADD_EVENT', 'communities', 16, NULL, '{"id": 2, "title": "Bổn mạng"}', '127.0.0.1', '2026-01-17 09:53:26.539742');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (180, 1, 'ADD_EVENT', 'communities', 16, NULL, '{"id": 3, "title": "bổn mạng"}', '127.0.0.1', '2026-01-17 10:04:01.493499');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (181, 1, 'ADD_MEMBER', 'communities', 16, NULL, '{"id": 1, "role": "superior", "notes": "giỏi", "end_date": null, "sister_id": 16, "start_date": "2024-12-18T17:00:00.000Z", "community_id": 16, "decision_date": null, "decision_number": "tốt", "decision_file_url": null}', '127.0.0.1', '2026-01-17 10:13:05.916609');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (182, 1, 'UPDATE', 'vocation_journey', 1, '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg\",\"name\":\"d5d020e528eea2b0fbff2.jpg\",\"size\":9340,\"uploaded_at\":\"2026-01-17T01:20:26.604Z\"}]", "sister_id": 16, "start_date": "1993-02-21T17:00:00.000Z", "community_id": 16, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg\",\"name\":\"d5d020e528eea2b0fbff2.jpg\",\"size\":9340,\"uploaded_at\":\"2026-01-17T01:20:26.604Z\"}]", "sister_id": 16, "start_date": "1993-02-20T17:00:00.000Z", "community_id": 15, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '127.0.0.1', '2026-01-17 10:16:01.573615');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (183, 1, 'UPDATE', 'vocation_journey', 1, '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg\",\"name\":\"d5d020e528eea2b0fbff2.jpg\",\"size\":9340,\"uploaded_at\":\"2026-01-17T01:20:26.604Z\"}]", "sister_id": 16, "start_date": "1993-02-20T17:00:00.000Z", "community_id": 15, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg\",\"name\":\"d5d020e528eea2b0fbff2.jpg\",\"size\":9340,\"uploaded_at\":\"2026-01-17T01:20:26.604Z\"}]", "sister_id": 16, "start_date": "1993-02-19T17:00:00.000Z", "community_id": 16, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '127.0.0.1', '2026-01-17 10:22:26.080775');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (184, 1, 'UPDATE', 'vocation_journey', 1, '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg\",\"name\":\"d5d020e528eea2b0fbff2.jpg\",\"size\":9340,\"uploaded_at\":\"2026-01-17T01:20:26.604Z\"}]", "sister_id": 16, "start_date": "1993-02-19T17:00:00.000Z", "community_id": 16, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg\",\"name\":\"d5d020e528eea2b0fbff2.jpg\",\"size\":9340,\"uploaded_at\":\"2026-01-17T01:20:26.604Z\"}]", "sister_id": 16, "start_date": "1993-02-18T17:00:00.000Z", "community_id": 15, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '127.0.0.1', '2026-01-17 10:23:19.131925');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (185, 1, 'UPDATE', 'vocation_journey', 1, '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg\",\"name\":\"d5d020e528eea2b0fbff2.jpg\",\"size\":9340,\"uploaded_at\":\"2026-01-17T01:20:26.604Z\"}]", "sister_id": 16, "start_date": "1993-02-18T17:00:00.000Z", "community_id": 15, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg\",\"name\":\"d5d020e528eea2b0fbff2.jpg\",\"size\":9340,\"uploaded_at\":\"2026-01-17T01:20:26.604Z\"}]", "sister_id": 16, "start_date": "1993-02-17T17:00:00.000Z", "community_id": 16, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '127.0.0.1', '2026-01-17 13:48:52.093396');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (186, 1, 'UPDATE', 'vocation_journey', 1, '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg\",\"name\":\"d5d020e528eea2b0fbff2.jpg\",\"size\":9340,\"uploaded_at\":\"2026-01-17T01:20:26.604Z\"}]", "sister_id": 16, "start_date": "1993-02-17T17:00:00.000Z", "community_id": 16, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg\",\"name\":\"d5d020e528eea2b0fbff2.jpg\",\"size\":9340,\"uploaded_at\":\"2026-01-17T01:20:26.604Z\"}]", "sister_id": 16, "start_date": "1993-02-16T17:00:00.000Z", "community_id": 15, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '127.0.0.1', '2026-01-17 13:50:17.777347');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (187, 1, 'UPDATE', 'vocation_journey', 2, '{"id": 2, "notes": null, "stage": "postulant", "end_date": null, "location": "Nhà Dòng Đà Lạt, Lâm Đồng", "superior": "16_Maria Trần Thị Mỹ Linh", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612756259-446856523.pdf\",\"name\":\"Giay chung sinh.pdf\",\"size\":235959,\"uploaded_at\":\"2026-01-17T01:19:16.267Z\"}]", "sister_id": 15, "start_date": "2024-12-16T17:00:00.000Z", "community_id": 15, "supervisor_id": null, "formation_director": "16_Maria Trần Thị Mỹ Linh"}', '{"id": 2, "notes": null, "stage": "postulant", "end_date": null, "location": "Nhà Dòng Đà Lạt, Lâm Đồng", "superior": "16_Maria Trần Thị Mỹ Linh", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612756259-446856523.pdf\",\"name\":\"Giay chung sinh.pdf\",\"size\":235959,\"uploaded_at\":\"2026-01-17T01:19:16.267Z\"}]", "sister_id": 15, "start_date": "2024-12-15T17:00:00.000Z", "community_id": 16, "supervisor_id": null, "formation_director": "16_Maria Trần Thị Mỹ Linh"}', '127.0.0.1', '2026-01-17 13:55:53.214015');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (188, 1, 'UPDATE', 'education', 2, '{"id": 2, "gpa": "3.75/4.0", "level": "bachelor", "major": "Thần học và Giáo lý", "notes": "Nữ tu Vũ Thị Minh Thọn đang theo học ngành Thần học và Giáo lý tại ĐH Khoa học Xã hội và Nhân văn TP.HCM. Kết quả học tập tốt với GPA 3.75/4.0. Dự kiến tốt nghiệp năm 2026.", "status": "dang_hoc", "end_date": "2024-05-31T17:00:00.000Z", "documents": [{"id": 1768613455415, "url": "http://localhost:5000/uploads/documents/1768613455414-712649413.pdf", "name": "Giay chung sinh.pdf", "size": 235959, "type": "application/pdf", "uploadedAt": "2026-01-17T01:30:55.415Z"}], "sister_id": 15, "start_date": "2022-08-31T17:00:00.000Z", "institution": "Đại học Khoa học Xã hội và Nhân văn TP.HCM", "thesis_title": "Vai trò của Giáo lý trong việc hình thành đức tin của người trẻ Công giáo Việt Nam", "certificate_url": null, "graduation_year": 2026}', '{"id": 2, "gpa": "3.75/4.0", "level": "bachelor", "major": "Thần học và Giáo lý", "notes": "Nữ tu Vũ Thị Minh Thọn đang theo học ngành Thần học và Giáo lý tại ĐH Khoa học Xã hội và Nhân văn TP.HCM. Kết quả học tập tốt với GPA 3.75/4.0. Dự kiến tốt nghiệp năm 2026.", "status": "da_tot_nghiep", "end_date": "2024-05-30T17:00:00.000Z", "documents": [{"id": 1768613455415, "url": "http://localhost:5000/uploads/documents/1768613455414-712649413.pdf", "name": "Giay chung sinh.pdf", "size": 235959, "type": "application/pdf", "uploadedAt": "2026-01-17T01:30:55.415Z"}], "sister_id": 15, "start_date": "2022-08-30T17:00:00.000Z", "institution": "Đại học Khoa học Xã hội và Nhân văn TP.HCM", "thesis_title": "Vai trò của Giáo lý trong việc hình thành đức tin của người trẻ Công giáo Việt Nam", "certificate_url": null, "graduation_year": 2026}', '127.0.0.1', '2026-01-17 14:04:43.277365');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (189, 1, 'CREATE', 'missions', 8, NULL, '{"id": 8, "field": "Y Tế - Chăm Sóc Sức Khỏe", "notes": null, "address": "12 Xô Viết Đà Lạt,vũng tàu", "end_date": null, "documents": "[]", "sister_id": 15, "start_date": "2024-01-12T17:00:00.000Z", "organization": "Trường THPT Thiên Ban", "specific_role": "Y Tá - Điều dưỡng Viện"}', '127.0.0.1', '2026-01-17 14:34:54.18976');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (190, 1, 'DELETE', 'missions', 4, '{"id": 4, "field": "education", "notes": "Test mission creation", "address": "123 Main St", "end_date": null, "documents": "[{\"name\":\"test.pdf\",\"url\":\"http://test.com/test.pdf\"}]", "sister_id": 1, "start_date": "2022-12-31T17:00:00.000Z", "organization": "High School A", "specific_role": "Teacher"}', NULL, '127.0.0.1', '2026-01-17 14:35:02.606118');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (191, 1, 'UPDATE', 'missions', 8, '{"id": 8, "field": "Y Tế - Chăm Sóc Sức Khỏe", "notes": null, "address": "12 Xô Viết Đà Lạt,vũng tàu", "end_date": null, "documents": "[]", "sister_id": 15, "start_date": "2024-01-12T17:00:00.000Z", "organization": "Trường THPT Thiên Ban", "specific_role": "Y Tá - Điều dưỡng Viện"}', '{"id": 8, "field": "Y Tế - Chăm Sóc Sức Khỏe", "notes": "", "address": "12 Xô Viết Đà Lạt,vũng tàu", "end_date": null, "documents": "[]", "sister_id": 15, "start_date": "2025-01-11T17:00:00.000Z", "organization": "Trường THPT Thiên Ban", "specific_role": "Y Tá - Điều dưỡng Viện"}', '127.0.0.1', '2026-01-17 14:35:41.575091');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (192, 1, 'UPDATE', 'users', 21, '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T08:13:18.276Z", "updated_at": "2026-01-17T08:13:18.278Z"}', '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T08:13:18.276Z", "updated_at": "2026-01-17T08:13:53.216Z"}', '127.0.0.1', '2026-01-17 15:13:53.218817');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (193, 1, 'UPDATE_PERMISSIONS', 'users', 21, NULL, '{"permissionIds": [5, 6, 7, 8, 40, 81, 82, 83, 84, 2, 4, 87, 3, 88, 89, 1, 86, 85, 22, 24, 23, 21, 14, 16, 15, 13, 18, 20, 19, 17, 26, 28, 27, 25, 31, 30, 29, 91, 35, 37, 90, 38, 36, 34, 39, 10, 12, 11, 9, 33, 32]}', '127.0.0.1', '2026-01-17 15:13:53.240618');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (194, 1, 'ASSIGN_COMMUNITIES', 'users', 21, NULL, '{"community_ids": [15]}', '127.0.0.1', '2026-01-17 15:13:53.250029');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (195, 1, 'UPDATE', 'users', 21, '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T08:13:18.276Z", "updated_at": "2026-01-17T08:13:53.216Z"}', '{"id": 21, "role": "viewer", "email": "admindalat@gmail.com", "phone": "0394459503", "avatar": "", "username": "admindalat", "full_name": "Admin Đà Lạt", "is_active": 1, "created_at": "2026-01-17T00:41:41.281Z", "data_scope": "community", "last_login": "2026-01-17T08:13:18.276Z", "updated_at": "2026-01-17T08:52:35.292Z"}', '127.0.0.1', '2026-01-17 15:52:35.299775');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (196, 1, 'UPDATE_PERMISSIONS', 'users', 21, NULL, '{"permissionIds": [5, 6, 7, 8, 40, 81, 82, 83, 84, 2, 4, 87, 3, 88, 89, 1, 86, 85, 22, 24, 23, 21, 14, 16, 15, 13, 18, 20, 19, 17, 26, 28, 27, 25, 31, 30, 29, 91, 35, 37, 90, 38, 36, 34, 39, 10, 12, 11, 9, 33, 32, 97, 99, 98, 96, 93, 95, 94, 92]}', '127.0.0.1', '2026-01-17 15:52:35.361839');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (197, 1, 'ASSIGN_COMMUNITIES', 'users', 21, NULL, '{"community_ids": [15]}', '127.0.0.1', '2026-01-17 15:52:35.376443');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (198, 21, 'UPDATE', 'vocation_journey', 1, '{"id": 1, "notes": null, "stage": "aspirant", "end_date": null, "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg\",\"name\":\"d5d020e528eea2b0fbff2.jpg\",\"size\":9340,\"uploaded_at\":\"2026-01-17T01:20:26.604Z\"}]", "sister_id": 16, "start_date": "1993-02-16T17:00:00.000Z", "community_id": 15, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '{"id": 1, "notes": null, "stage": "aspirant", "end_date": "2020-12-31T17:00:00.000Z", "location": null, "superior": "15_Thérèse Vũ Thị Minh Thọn", "documents": "[{\"url\":\"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg\",\"name\":\"d5d020e528eea2b0fbff2.jpg\",\"size\":9340,\"uploaded_at\":\"2026-01-17T01:20:26.604Z\"}]", "sister_id": 16, "start_date": "2019-12-31T17:00:00.000Z", "community_id": 15, "supervisor_id": null, "formation_director": "15_Thérèse Vũ Thị Minh Thọn"}', '127.0.0.1', '2026-01-17 16:08:06.465149');
INSERT INTO public.audit_logs (id, user_id, action, table_name, record_id, old_value, new_value, ip_address, created_at) VALUES (199, 21, 'ADD_EVENT', 'communities', 15, NULL, '{"id": 4, "title": "Khấn đà lạt"}', '127.0.0.1', '2026-01-17 16:17:11.944947');


--
-- Data for Name: chat_conversations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.chat_conversations (id, conversation_id, user_id, user_message, ai_response, context_used, entities_extracted, intent, tokens_used, cost, is_helpful, feedback, created_at, updated_at) VALUES (1, 'e68e1ea7-721e-42fc-b361-3c56515a84ec', 1, 'xin chào', 'Xin chào! 😊 Bạn có câu hỏi gì về nữ tu, hành trình ơn gọi hay cộng đoàn không? Tôi sẵn sàng giúp đỡ!', '{"data": {"totalSisters": "0", "totalCommunities": "2"}, "text": "📋 Thông tin hệ thống:\n- Tổng số nữ tu: 0\n- Tổng số cộng đoàn: 2\n\nBạn có thể hỏi tôi về thông tin nữ tu, hành trình ơn gọi, cộng đoàn, thống kê, và nhiều nội dung khác.", "sources": []}', '{"age_question": false, "list_question": false, "count_question": false}', 'greeting', 822, 0.000138, NULL, NULL, '2026-01-11 08:29:21.677116', '2026-01-11 08:29:21.677116');


--
-- Data for Name: communities; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.communities (id, code, name, address, created_at, updated_at, phone, email, established_date, status, description) VALUES (15, 'CD1768585249936', 'Cộng Đoàn Mẫu Đà Lạt', '250 Trần Phú, Thành phố Đà Lạt, Lâm Đồng', '2026-01-17 00:40:49.941545', NULL, '0263 382 1234', 'template.dalat@ospvietnam.org', '2019-01-01', 'active', 'Cộng Đoàn Mẫu Đà Lạt là mẫu tiêu chuẩn cho các cộng đoàn ở Đà Lạt. Được thiết kế để cung cấp một cấu trúc tổ chức hiệu quả, đây là cộng đoàn có các chức năng đầy đủ để truyền giáo, giáo dục tôn giáo và hỗ trợ cộng đồng. Mẫu này tuân theo các nguyên tắc quản lý tâm linh và được sử dụng như một tài liệu tham khảo cho các hoạt động cộng đoàn.');
INSERT INTO public.communities (id, code, name, address, created_at, updated_at, phone, email, established_date, status, description) VALUES (16, 'CD1768585344732', 'Cộng Đoàn Hà Nội', '72 Hàng Ngang, Quận Hoàn Kiếm, Thành phố Hà Nội', '2026-01-17 00:42:24.735898', NULL, '0243 825 8456', 'congdoan.hanoi@ospvietnam.org', '2018-05-05', 'active', 'Cộng Đoàn Hà Nội là một tổ chức tâm linh quan trọng nằm ở thủ đô Hà Nội. Được thành lập với sứ mạng truyền giáo và phục vụ cộng đồng, Cộng Đoàn Hà Nội hoạt động trong các lĩnh vực giáo dục tôn giáo, từ thiện xã hội và nuôi dạy các tín đồ. Cộng Đoàn cam kết xây dựng một cộng đồng mạnh mẽ, duy trì các giá trị tâm linh truyền thống và phục vụ nhân dân Hà Nội.');


--
-- Data for Name: community_assignments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.community_assignments (id, sister_id, community_id, role, start_date, end_date, decision_number, decision_date, decision_file_url, notes) VALUES (1, 16, 16, 'superior', '2024-12-19', NULL, 'tốt', NULL, NULL, 'giỏi');


--
-- Data for Name: community_events; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.community_events (id, community_id, title, description, event_date, created_at) VALUES (1, 16, 'Lễ bổn mạng', 'Tốt', '2026-01-01', '2026-01-17 09:05:16.635816');
INSERT INTO public.community_events (id, community_id, title, description, event_date, created_at) VALUES (2, 16, 'Bổn mạng', 'xin chào', '2026-01-17', '2026-01-17 09:53:26.526628');
INSERT INTO public.community_events (id, community_id, title, description, event_date, created_at) VALUES (3, 16, 'bổn mạng', 'đang diễn ra', '2026-01-17', '2026-01-17 10:04:01.49037');
INSERT INTO public.community_events (id, community_id, title, description, event_date, created_at) VALUES (4, 15, 'Khấn đà lạt', 'Khấn 3 bạn', '2024-01-01', '2026-01-17 16:17:11.906723');


--
-- Data for Name: community_roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.community_roles (id, code, name, description, display_order, color, is_default, is_active, created_at, updated_at) VALUES (1, 'superior', 'Bề trên', NULL, 1, '#d63031', true, true, '2026-01-11 00:33:34.108267', '2026-01-11 00:33:34.108267');
INSERT INTO public.community_roles (id, code, name, description, display_order, color, is_default, is_active, created_at, updated_at) VALUES (4, 'assistant', 'Phó bề trên', NULL, 2, '#2d3436', true, true, '2026-01-11 00:33:34.120166', '2026-01-11 00:33:34.120166');
INSERT INTO public.community_roles (id, code, name, description, display_order, color, is_default, is_active, created_at, updated_at) VALUES (7, 'secretary', 'Thư ký', NULL, 3, '#6c5ce7', true, true, '2026-01-11 00:33:34.120949', '2026-01-11 00:33:34.120949');
INSERT INTO public.community_roles (id, code, name, description, display_order, color, is_default, is_active, created_at, updated_at) VALUES (12, 'treasurer', 'Thủ quỹ', NULL, 4, '#e84393', true, true, '2026-01-11 00:33:34.12151', '2026-01-11 00:33:34.12151');
INSERT INTO public.community_roles (id, code, name, description, display_order, color, is_default, is_active, created_at, updated_at) VALUES (15, 'member', 'Thành viên', NULL, 5, '#0984e3', true, true, '2026-01-11 00:33:34.122125', '2026-01-11 00:33:34.122125');


--
-- Data for Name: departure_records; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: education; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.education (id, sister_id, level, major, institution, start_date, end_date, certificate_url, graduation_year, status, gpa, thesis_title, notes, documents) VALUES (1, 16, 'master', 'Thần học và Triết học', 'Đại học Khoa học Xã hội và Nhân văn TP.HCM', '2022-09-01', '2024-06-30', NULL, 2024, 'da_tot_nghiep', '3.75/4.0', NULL, 'Hoàn thành xuất sắc chương trình Thạc sĩ với luận văn nghiên cứu về vai trò của Giáo hội trong xã hội đương đại.', '[{"id": 1768613445218, "url": "http://localhost:5000/uploads/documents/1768613445216-806870501.jpg", "name": "d5d020e528eea2b0fbff2.jpg", "size": 9340, "type": "image/jpeg", "uploadedAt": "2026-01-17T01:30:45.218Z"}]');
INSERT INTO public.education (id, sister_id, level, major, institution, start_date, end_date, certificate_url, graduation_year, status, gpa, thesis_title, notes, documents) VALUES (2, 15, 'bachelor', 'Thần học và Giáo lý', 'Đại học Khoa học Xã hội và Nhân văn TP.HCM', '2022-08-31', '2024-05-31', NULL, 2026, 'da_tot_nghiep', '3.75/4.0', 'Vai trò của Giáo lý trong việc hình thành đức tin của người trẻ Công giáo Việt Nam', 'Nữ tu Vũ Thị Minh Thọn đang theo học ngành Thần học và Giáo lý tại ĐH Khoa học Xã hội và Nhân văn TP.HCM. Kết quả học tập tốt với GPA 3.75/4.0. Dự kiến tốt nghiệp năm 2026.', '[{"id": 1768613455415, "url": "http://localhost:5000/uploads/documents/1768613455414-712649413.pdf", "name": "Giay chung sinh.pdf", "size": 235959, "type": "application/pdf", "uploadedAt": "2026-01-17T01:30:55.415Z"}]');


--
-- Data for Name: education_levels; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.education_levels (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (1, 'secondary', 'Trung học', NULL, 1, '#6c757d', true, '2026-01-11 01:57:16.199788', '2026-01-11 01:57:16.199788');
INSERT INTO public.education_levels (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (2, 'high_school', 'Phổ thông', NULL, 2, '#17a2b8', true, '2026-01-11 01:57:16.199788', '2026-01-11 01:57:16.199788');
INSERT INTO public.education_levels (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (3, 'vocational', 'Trung cấp', NULL, 3, '#20c997', true, '2026-01-11 01:57:16.199788', '2026-01-11 01:57:16.199788');
INSERT INTO public.education_levels (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (4, 'college', 'Cao đẳng', NULL, 4, '#fd7e14', true, '2026-01-11 01:57:16.199788', '2026-01-11 01:57:16.199788');
INSERT INTO public.education_levels (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (5, 'bachelor', 'Đại học', NULL, 5, '#0d6efd', true, '2026-01-11 01:57:16.199788', '2026-01-11 01:57:16.199788');
INSERT INTO public.education_levels (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (6, 'master', 'Thạc sĩ', NULL, 6, '#6f42c1', true, '2026-01-11 01:57:16.199788', '2026-01-11 01:57:16.199788');
INSERT INTO public.education_levels (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (7, 'doctorate', 'Tiến sĩ', NULL, 7, '#dc3545', true, '2026-01-11 01:57:16.199788', '2026-01-11 01:57:16.199788');
INSERT INTO public.education_levels (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (8, 'certificate', 'Chứng chỉ', NULL, 8, '#ffc107', true, '2026-01-11 01:57:16.199788', '2026-01-11 01:57:16.199788');
INSERT INTO public.education_levels (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (9, 'other', 'Khác', NULL, 99, '#adb5bd', true, '2026-01-11 01:57:16.199788', '2026-01-11 01:57:16.199788');


--
-- Data for Name: evaluations; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: health_records; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: journey_stages; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.journey_stages (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (1, 'aspirant', 'Ứng sinh', NULL, 1, '#17a2b8', true, '2026-01-11 01:55:42.606103', '2026-01-11 01:55:42.606103');
INSERT INTO public.journey_stages (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (2, 'postulant', 'Tập sinh', NULL, 2, '#ffc107', true, '2026-01-11 01:55:42.610764', '2026-01-11 01:55:42.610764');
INSERT INTO public.journey_stages (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (3, 'novice', 'Tập sinh khấn', NULL, 3, '#fd7e14', true, '2026-01-11 01:55:42.612573', '2026-01-11 01:55:42.612573');
INSERT INTO public.journey_stages (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (4, 'temporary_vows', 'Khấn tạm', NULL, 4, '#6f42c1', true, '2026-01-11 01:55:42.613813', '2026-01-11 01:55:42.613813');
INSERT INTO public.journey_stages (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (5, 'perpetual_vows', 'Khấn trọn', NULL, 5, '#28a745', true, '2026-01-11 01:55:42.614856', '2026-01-11 01:55:42.614856');


--
-- Data for Name: missions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.missions (id, sister_id, field, specific_role, start_date, end_date, notes, organization, address, documents) VALUES (8, 15, 'Y Tế - Chăm Sóc Sức Khỏe', 'Y Tá - Điều dưỡng Viện', '2025-01-12', NULL, '', 'Trường THPT Thiên Ban', '12 Xô Viết Đà Lạt,vũng tàu', '[]');


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (1, 'sisters.view', 'Xem danh sách nữ tu', 'Cho phép xem danh sách và thông tin nữ tu', 'sisters', true, '2026-01-11 00:59:35.510257');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (2, 'sisters.create', 'Thêm nữ tu mới', 'Cho phép tạo hồ sơ nữ tu mới', 'sisters', true, '2026-01-11 00:59:35.516732');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (3, 'sisters.update', 'Chỉnh sửa nữ tu', 'Cho phép cập nhật thông tin nữ tu', 'sisters', true, '2026-01-11 00:59:35.517745');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (4, 'sisters.delete', 'Xóa nữ tu', 'Cho phép xóa hồ sơ nữ tu', 'sisters', true, '2026-01-11 00:59:35.518834');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (5, 'communities.view', 'Xem cộng đoàn', 'Cho phép xem danh sách cộng đoàn', 'communities', true, '2026-01-11 00:59:35.519759');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (6, 'communities.create', 'Thêm cộng đoàn', 'Cho phép tạo cộng đoàn mới', 'communities', true, '2026-01-11 00:59:35.520506');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (7, 'communities.update', 'Chỉnh sửa cộng đoàn', 'Cho phép cập nhật thông tin cộng đoàn', 'communities', true, '2026-01-11 00:59:35.52113');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (8, 'communities.delete', 'Xóa cộng đoàn', 'Cho phép xóa cộng đoàn', 'communities', true, '2026-01-11 00:59:35.521711');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (10, 'journey.create', 'Thêm giai đoạn mới', 'Cho phép tạo giai đoạn mới', 'Hành trình Ơn Gọi', true, '2026-01-11 00:59:35.523165');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (11, 'journey.update', 'Chỉnh sửa hành trình', 'Cho phép cập nhật hành trình', 'Hành trình Ơn Gọi', true, '2026-01-11 00:59:35.52415');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (12, 'journey.delete', 'Xóa giai đoạn', 'Cho phép xóa hành trình', 'Hành trình Ơn Gọi', true, '2026-01-11 00:59:35.525456');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (13, 'missions.view', 'Xem sứ vụ', 'Cho phép xem danh sách sứ vụ', 'missions', true, '2026-01-11 00:59:35.526211');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (14, 'missions.create', 'Thêm sứ vụ', 'Cho phép tạo sứ vụ mới', 'missions', true, '2026-01-11 00:59:35.526941');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (15, 'missions.update', 'Chỉnh sửa sứ vụ', 'Cho phép cập nhật sứ vụ', 'missions', true, '2026-01-11 00:59:35.527738');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (16, 'missions.delete', 'Xóa sứ vụ', 'Cho phép xóa sứ vụ', 'missions', true, '2026-01-11 00:59:35.528426');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (17, 'health.view', 'Xem sức khỏe', 'Cho phép xem hồ sơ sức khỏe', 'health', true, '2026-01-11 00:59:35.529152');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (18, 'health.create', 'Thêm hồ sơ sức khỏe', 'Cho phép tạo hồ sơ sức khỏe', 'health', true, '2026-01-11 00:59:35.529925');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (19, 'health.update', 'Chỉnh sửa sức khỏe', 'Cho phép cập nhật hồ sơ sức khỏe', 'health', true, '2026-01-11 00:59:35.530798');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (20, 'health.delete', 'Xóa sức khỏe', 'Cho phép xóa hồ sơ sức khỏe', 'health', true, '2026-01-11 00:59:35.531431');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (21, 'education.view', 'Xem học vấn', 'Cho phép xem hồ sơ học vấn', 'education', true, '2026-01-11 00:59:35.532011');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (22, 'education.create', 'Thêm học vấn', 'Cho phép tạo hồ sơ học vấn', 'education', true, '2026-01-11 00:59:35.532607');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (23, 'education.update', 'Chỉnh sửa học vấn', 'Cho phép cập nhật học vấn', 'education', true, '2026-01-11 00:59:35.533226');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (24, 'education.delete', 'Xóa học vấn', 'Cho phép xóa học vấn', 'education', true, '2026-01-11 00:59:35.53382');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (25, 'evaluations.view', 'Xem đánh giá', 'Cho phép xem đánh giá', 'evaluations', true, '2026-01-11 00:59:35.534376');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (26, 'evaluations.create', 'Thêm đánh giá', 'Cho phép tạo đánh giá mới', 'evaluations', true, '2026-01-11 00:59:35.534906');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (27, 'evaluations.update', 'Chỉnh sửa đánh giá', 'Cho phép cập nhật đánh giá', 'evaluations', true, '2026-01-11 00:59:35.535738');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (28, 'evaluations.delete', 'Xóa đánh giá', 'Cho phép xóa đánh giá', 'evaluations', true, '2026-01-11 00:59:35.536288');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (29, 'reports.view', 'Xem báo cáo', 'Cho phép xem các báo cáo', 'reports', true, '2026-01-11 00:59:35.536848');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (30, 'reports.generate', 'Tạo báo cáo', 'Cho phép tạo báo cáo mới', 'reports', true, '2026-01-11 00:59:35.537419');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (31, 'reports.export', 'Xuất báo cáo', 'Cho phép xuất báo cáo', 'reports', true, '2026-01-11 00:59:35.537973');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (32, 'settings.view', 'Xem cài đặt', 'Cho phép xem cài đặt hệ thống', 'settings', true, '2026-01-11 00:59:35.538518');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (33, 'settings.update', 'Chỉnh sửa cài đặt', 'Cho phép thay đổi cài đặt hệ thống', 'settings', true, '2026-01-11 00:59:35.539016');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (34, 'users.view', 'Xem người dùng', 'Cho phép xem danh sách người dùng', 'users', true, '2026-01-11 00:59:35.539539');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (35, 'users.create', 'Thêm người dùng', 'Cho phép tạo tài khoản mới', 'users', true, '2026-01-11 00:59:35.540053');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (36, 'users.update', 'Chỉnh sửa người dùng', 'Cho phép cập nhật thông tin người dùng', 'users', true, '2026-01-11 00:59:35.540798');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (37, 'users.delete', 'Xóa người dùng', 'Cho phép xóa tài khoản', 'users', true, '2026-01-11 00:59:35.541883');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (38, 'users.manage_permissions', 'Quản lý phân quyền', 'Cho phép gán quyền và cộng đoàn cho người dùng', 'users', true, '2026-01-11 00:59:35.542629');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (39, 'audit.view', 'Xem nhật ký', 'Cho phép xem nhật ký hệ thống', 'audit', true, '2026-01-11 00:59:35.543357');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (40, 'dashboard.view', 'Xem tổng quan', 'Cho phép xem trang tổng quan', 'dashboard', true, '2026-01-11 00:59:35.544293');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (81, 'posts.view', 'Xem bài đăng', 'Cho phép xem danh sách và chi tiết bài đăng', 'posts', true, '2026-01-11 01:18:25.905618');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (82, 'posts.create', 'Tạo bài đăng', 'Cho phép tạo bài đăng mới', 'posts', true, '2026-01-11 01:18:25.906364');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (83, 'posts.update', 'Cập nhật bài đăng', 'Cho phép cập nhật bài đăng', 'posts', true, '2026-01-11 01:18:25.906606');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (84, 'posts.delete', 'Xóa bài đăng', 'Cho phép xóa bài đăng', 'posts', true, '2026-01-11 01:18:25.906839');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (85, 'sisters.view_list', 'Xem danh sách tu sĩ', 'Quyền xem danh sách tu sĩ', 'sisters', true, '2026-01-16 20:06:48.688217');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (86, 'sisters.view_detail', 'Xem chi tiết tu sĩ', 'Quyền xem thông tin chi tiết tu sĩ', 'sisters', true, '2026-01-16 20:06:48.69315');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (87, 'sisters.edit', 'Chỉnh sửa tu sĩ', 'Quyền chỉnh sửa thông tin tu sĩ', 'sisters', true, '2026-01-16 20:06:48.69526');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (88, 'sisters.upload_avatar', 'Upload ảnh tu sĩ', 'Quyền upload ảnh đại diện tu sĩ', 'sisters', true, '2026-01-16 20:06:48.697175');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (89, 'sisters.upload_documents', 'Upload tài liệu tu sĩ', 'Quyền upload tài liệu tu sĩ', 'sisters', true, '2026-01-16 20:06:48.69942');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (90, 'users.edit', 'Chỉnh sửa người dùng', 'Quyền chỉnh sửa thông tin người dùng', 'users', true, '2026-01-16 20:06:48.701228');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (91, 'users.assign_permissions', 'Gán quyền người dùng', 'Quyền gán quyền cho người dùng', 'users', true, '2026-01-16 20:06:48.702658');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (92, 'departure.view', 'Xem lịch đi vắng', NULL, 'Quản lý Đi vắng', true, '2026-01-17 15:50:24.493425');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (93, 'departure.create', 'Thêm lịch đi vắng', NULL, 'Quản lý Đi vắng', true, '2026-01-17 15:50:24.498295');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (94, 'departure.update', 'Chỉnh sửa lịch đi vắng', NULL, 'Quản lý Đi vắng', true, '2026-01-17 15:50:24.499732');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (95, 'departure.delete', 'Xóa lịch đi vắng', NULL, 'Quản lý Đi vắng', true, '2026-01-17 15:50:24.501134');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (96, 'community_assignment.view', 'Xem thông tin bổ nhiệm', NULL, 'Bổ nhiệm & Phân công', true, '2026-01-17 15:50:24.502267');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (97, 'community_assignment.create', 'Phân bổ chị em', NULL, 'Bổ nhiệm & Phân công', true, '2026-01-17 15:50:24.503328');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (98, 'community_assignment.update', 'Chỉnh sửa phân bổ', NULL, 'Bổ nhiệm & Phân công', true, '2026-01-17 15:50:24.504238');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (99, 'community_assignment.delete', 'Kết thúc/Xóa phân bổ', NULL, 'Bổ nhiệm & Phân công', true, '2026-01-17 15:50:24.505253');
INSERT INTO public.permissions (id, code, name, description, module, is_active, created_at) VALUES (9, 'journey.view', 'Xem hành trình ơn gọi', 'Cho phép xem hành trình ơn gọi', 'Hành trình Ơn Gọi', true, '2026-01-11 00:59:35.522389');


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.posts (id, title, slug, content, excerpt, category, status, is_pinned, featured_image, attachments, author_id, view_count, published_at, created_at, updated_at, deleted_at, summary, is_important, tags) VALUES (1, 'Chào mừng đến với hệ thống', NULL, 'Đây là bài đăng đầu tiên trên hệ thống quản lý Hội Dòng OSP. Chúc các chị em sử dụng hệ thống hiệu quả!', 'Bài đăng chào mừng từ ban quản trị.', 'thong-bao', 'published', false, NULL, '[]', 1, 2, '2026-01-11 01:07:54.472677', '2026-01-11 01:07:54.472677', '2026-01-11 08:41:33.399', NULL, NULL, false, '[]');


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('001_create_users_table.js', '2026-01-11 01:54:22.851605+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('002_create_communities_table.js', '2026-01-11 01:54:41.840348+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('003_create_sisters_table.js', '2026-01-11 01:54:50.467421+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('004_create_vocation_journey_table.js', '2026-01-11 01:54:50.473718+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('005_create_community_assignments_table.js', '2026-01-11 01:54:50.478197+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('006_create_missions_table.js', '2026-01-11 01:54:50.482144+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('007_create_education_table.js', '2026-01-11 01:54:50.486216+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('008_create_training_courses_table.js', '2026-01-11 01:54:50.490747+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('009_create_health_records_table.js', '2026-01-11 01:54:57.206291+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('010_create_evaluations_table.js', '2026-01-11 01:55:03.853182+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('011_create_departure_records_table.js', '2026-01-11 01:55:03.85887+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('012_create_audit_logs_table.js', '2026-01-11 01:55:03.862973+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('013_seed_initial_data.js', '2026-01-11 01:55:42.488079+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('014_add_sister_fields.js', '2026-01-11 01:55:42.506407+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('020_add_profile_fields_to_users.js', '2026-01-11 01:55:42.521396+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('021_add_extra_fields_to_sisters.js', '2026-01-11 01:55:42.559099+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('022_create_lookup_tables.js', '2026-01-11 01:55:42.624433+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('023_add_documents_to_sisters.js', '2026-01-11 01:55:42.635051+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('024_add_extra_health_record_fields.js', '2026-01-11 01:55:42.67574+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('024_alter_status_column.js', '2026-01-11 01:55:42.69005+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('024_update_departure_records.js', '2026-01-11 01:55:42.711393+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('025_alter_current_stage_column.js', '2026-01-11 01:55:42.721992+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('025_ensure_departure_records_columns.js', '2026-01-11 01:55:42.741649+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('026_alter_community_type.js', '2026-01-11 01:55:42.751882+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('026_update_evaluations_table.js', '2026-01-11 01:55:42.772397+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('027_add_recommendations_column.js', '2026-01-11 01:55:42.776351+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('027_drop_community_type.js', '2026-01-11 01:55:42.788228+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('028_add_community_fields.js', '2026-01-11 01:55:42.800868+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('029_cleanup_sisters_columns.js', '2026-01-11 01:55:42.814381+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('030_add_vocation_journey_fields.js', '2026-01-11 01:55:42.818382+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('031_add_education_extra_fields.js', '2026-01-11 01:55:42.828293+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('040_create_chat_conversations.js', '2026-01-11 01:55:42.843712+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('041_create_notifications_table.js', '2026-01-11 01:55:42.867061+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('100_remove_role_system.js', '2026-01-11 01:55:42.87593+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('042_create_education_levels_table.js', '2026-01-11 01:57:16.249175+07');
INSERT INTO public.schema_migrations (file_name, applied_at) VALUES ('043_add_users_data_scope.js', '2026-01-11 07:36:41.724514+07');


--
-- Data for Name: sister_statuses; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sister_statuses (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (1, 'active', 'Đang hoạt động', NULL, 1, '#28a745', true, '2026-01-11 01:55:42.617327', '2026-01-11 01:55:42.617327');
INSERT INTO public.sister_statuses (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (2, 'inactive', 'Tạm nghỉ', NULL, 2, '#ffc107', true, '2026-01-11 01:55:42.620369', '2026-01-11 01:55:42.620369');
INSERT INTO public.sister_statuses (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (3, 'leave', 'Đã rời', NULL, 3, '#6c757d', true, '2026-01-11 01:55:42.621176', '2026-01-11 01:55:42.621176');
INSERT INTO public.sister_statuses (id, code, name, description, display_order, color, is_active, created_at, updated_at) VALUES (4, 'deceased', 'Đã qua đời', NULL, 4, '#343a40', true, '2026-01-11 01:55:42.621858', '2026-01-11 01:55:42.621858');


--
-- Data for Name: sisters; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sisters (id, code, birth_name, date_of_birth, place_of_birth, nationality, father_name, mother_name, family_religion, baptism_date, baptism_place, confirmation_date, first_communion_date, phone, email, emergency_contact_name, emergency_contact_phone, photo_url, status, created_by, created_at, updated_at, saint_name, permanent_address, notes, id_card, id_card_date, id_card_place, current_address, father_occupation, mother_occupation, siblings_count, family_address, current_stage, current_community_id, documents, hometown) VALUES (1, 'TEST001', 'Test Sister', '1990-01-15', 'Test City', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'left', 1, '2026-01-16 19:44:46.226665', '2026-01-16 19:44:46.256771', 'Maria', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.sisters (id, code, birth_name, date_of_birth, place_of_birth, nationality, father_name, mother_name, family_religion, baptism_date, baptism_place, confirmation_date, first_communion_date, phone, email, emergency_contact_name, emergency_contact_phone, photo_url, status, created_by, created_at, updated_at, saint_name, permanent_address, notes, id_card, id_card_date, id_card_place, current_address, father_occupation, mother_occupation, siblings_count, family_address, current_stage, current_community_id, documents, hometown) VALUES (6, 'TEST1768567646669', 'Test Sister', '1990-01-15', 'Test City', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'left', 1, '2026-01-16 19:47:26.679916', '2026-01-16 19:47:26.694896', 'Maria', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.sisters (id, code, birth_name, date_of_birth, place_of_birth, nationality, father_name, mother_name, family_religion, baptism_date, baptism_place, confirmation_date, first_communion_date, phone, email, emergency_contact_name, emergency_contact_phone, photo_url, status, created_by, created_at, updated_at, saint_name, permanent_address, notes, id_card, id_card_date, id_card_place, current_address, father_occupation, mother_occupation, siblings_count, family_address, current_stage, current_community_id, documents, hometown) VALUES (3, 'T001', 'Test', '1990-01-15', 'Test', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'left', 1, '2026-01-16 19:46:03.768589', '2026-01-17 00:42:54.546797', 'Maria', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.sisters (id, code, birth_name, date_of_birth, place_of_birth, nationality, father_name, mother_name, family_religion, baptism_date, baptism_place, confirmation_date, first_communion_date, phone, email, emergency_contact_name, emergency_contact_phone, photo_url, status, created_by, created_at, updated_at, saint_name, permanent_address, notes, id_card, id_card_date, id_card_place, current_address, father_occupation, mother_occupation, siblings_count, family_address, current_stage, current_community_id, documents, hometown) VALUES (16, 'NT-002', 'Trần Thị Mỹ Linh', '1990-03-15', 'Hà Nội', 'Việt Nam', 'Trần Văn Hũng', 'Trần Thị Hạnh', 'Công Giáo', '1990-04-05', 'Nhà thờ Hà Nội', '2005-05-15', '2010-06-20', '0987654321', 'mylinh@example.com', 'Trần Thị Lý', '0912345678', '', 'active', 1, '2026-01-17 01:01:47.140526', NULL, 'Maria', '123 Đường LẾ Thanh Tôn, Hà Nội', 'Nư tu mịa y chí sự phục vụ của Đạo. Nhu cầu phát triển bản thân và còn người quá quý với mề. Đã tham gia các hoạt động đời sống tập thể và có tăng Đạo sãu sắc.', '0123456789123', '2018-01-10', 'Công an Hà Nội', '456 Đường Nguyễn Huệ, TP.HCM', 'Nông dân', 'Nông dân', 3, 'Xã An Hẻ, Hưyện Quốc Oai, Hà Nội', NULL, NULL, NULL, 'Hà Tĩ');
INSERT INTO public.sisters (id, code, birth_name, date_of_birth, place_of_birth, nationality, father_name, mother_name, family_religion, baptism_date, baptism_place, confirmation_date, first_communion_date, phone, email, emergency_contact_name, emergency_contact_phone, photo_url, status, created_by, created_at, updated_at, saint_name, permanent_address, notes, id_card, id_card_date, id_card_place, current_address, father_occupation, mother_occupation, siblings_count, family_address, current_stage, current_community_id, documents, hometown) VALUES (15, 'NT-001', 'Vũ Thị Minh Thy', '1998-07-21', 'Thái Bình', 'Việt Nam', 'Vũ Văn Hợp', 'Trần Thị Thường', 'Công giáo', '1998-08-27', 'Nhà thờ Thái Bình', '2012-04-14', '2014-05-17', '0987654321', 'minhthuan.teresa@ospvietnam.org', NULL, NULL, '', 'active', 1, '2026-01-17 01:01:33.615876', '2026-01-17 08:45:36.118445', 'Thérèse', '45 Trạn Quốc Thừng, Thái Bình', 'Nữ tu có bến nhân trong đức tin và sự tận tâm trong công việc. Tình cảm yêu thường sâu sắc, sẵn sàng phục vụ và cư thương những người kém may mắn. Đặc biệt quan tâm đến người cũ tuổi và thanh niên.', '234567891234', '2021-03-07', 'Thái Bình', '45 Trạn Quốc Thừng, Thái Bình', 'Nông dân', 'Nông dân', 1, NULL, NULL, NULL, NULL, 'Thái Bình');


--
-- Data for Name: training_courses; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: user_communities; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_communities (id, user_id, community_id, granted_by, granted_at) VALUES (7, 21, 15, 1, '2026-01-17 15:52:35.374467');


--
-- Data for Name: user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (1, 1, 1, 1, '2026-01-11 00:59:35.548895');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (2, 1, 2, 1, '2026-01-11 00:59:35.566454');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (3, 1, 3, 1, '2026-01-11 00:59:35.568399');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (4, 1, 4, 1, '2026-01-11 00:59:35.569644');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (5, 1, 5, 1, '2026-01-11 00:59:35.57084');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (6, 1, 6, 1, '2026-01-11 00:59:35.572081');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (7, 1, 7, 1, '2026-01-11 00:59:35.57365');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (8, 1, 8, 1, '2026-01-11 00:59:35.575499');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (9, 1, 9, 1, '2026-01-11 00:59:35.577276');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (10, 1, 10, 1, '2026-01-11 00:59:35.578673');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (11, 1, 11, 1, '2026-01-11 00:59:35.580087');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (12, 1, 12, 1, '2026-01-11 00:59:35.581388');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (13, 1, 13, 1, '2026-01-11 00:59:35.58232');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (14, 1, 14, 1, '2026-01-11 00:59:35.583124');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (15, 1, 15, 1, '2026-01-11 00:59:35.583759');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (16, 1, 16, 1, '2026-01-11 00:59:35.584468');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (17, 1, 17, 1, '2026-01-11 00:59:35.585145');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (18, 1, 18, 1, '2026-01-11 00:59:35.585719');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (19, 1, 19, 1, '2026-01-11 00:59:35.586287');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (20, 1, 20, 1, '2026-01-11 00:59:35.586823');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (21, 1, 21, 1, '2026-01-11 00:59:35.587385');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (22, 1, 22, 1, '2026-01-11 00:59:35.587974');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (23, 1, 23, 1, '2026-01-11 00:59:35.588532');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (24, 1, 24, 1, '2026-01-11 00:59:35.589082');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (25, 1, 25, 1, '2026-01-11 00:59:35.589637');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (26, 1, 26, 1, '2026-01-11 00:59:35.590425');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (27, 1, 27, 1, '2026-01-11 00:59:35.591884');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (28, 1, 28, 1, '2026-01-11 00:59:35.592873');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (29, 1, 29, 1, '2026-01-11 00:59:35.593853');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (30, 1, 30, 1, '2026-01-11 00:59:35.59491');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (31, 1, 31, 1, '2026-01-11 00:59:35.595836');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (32, 1, 32, 1, '2026-01-11 00:59:35.596508');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (33, 1, 33, 1, '2026-01-11 00:59:35.597113');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (34, 1, 34, 1, '2026-01-11 00:59:35.597631');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (35, 1, 35, 1, '2026-01-11 00:59:35.598201');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (36, 1, 36, 1, '2026-01-11 00:59:35.598753');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (37, 1, 37, 1, '2026-01-11 00:59:35.59933');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (38, 1, 38, 1, '2026-01-11 00:59:35.599853');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (39, 1, 39, 1, '2026-01-11 00:59:35.600388');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (40, 1, 40, 1, '2026-01-11 00:59:35.60091');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (81, 1, 81, 1, '2026-01-11 01:18:25.916095');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (82, 1, 82, 1, '2026-01-11 01:18:25.921326');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (83, 1, 83, 1, '2026-01-11 01:18:25.921746');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (84, 1, 84, 1, '2026-01-11 01:18:25.922131');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (257, 21, 5, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (258, 21, 6, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (259, 21, 7, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (260, 21, 8, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (261, 21, 40, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (262, 21, 81, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (263, 21, 82, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (264, 21, 83, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (265, 21, 84, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (266, 21, 2, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (267, 21, 4, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (268, 21, 87, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (269, 21, 3, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (270, 21, 88, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (271, 21, 89, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (272, 21, 1, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (273, 21, 86, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (274, 21, 85, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (275, 21, 22, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (276, 21, 24, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (277, 21, 23, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (278, 21, 21, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (279, 21, 14, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (280, 21, 16, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (281, 21, 15, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (282, 21, 13, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (283, 21, 18, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (284, 21, 20, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (285, 21, 19, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (286, 21, 17, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (287, 21, 26, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (288, 21, 28, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (289, 21, 27, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (290, 21, 25, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (291, 21, 31, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (292, 21, 30, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (293, 21, 29, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (294, 21, 91, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (295, 21, 35, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (296, 21, 37, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (297, 21, 90, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (298, 21, 38, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (299, 21, 36, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (300, 21, 34, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (301, 21, 39, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (302, 21, 10, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (303, 21, 12, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (304, 21, 11, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (305, 21, 9, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (306, 21, 33, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (307, 21, 32, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (308, 21, 97, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (309, 21, 99, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (310, 21, 98, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (311, 21, 96, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (312, 21, 93, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (313, 21, 95, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (314, 21, 94, 1, '2026-01-17 15:52:35.328436');
INSERT INTO public.user_permissions (id, user_id, permission_id, granted_by, granted_at) VALUES (315, 21, 92, 1, '2026-01-17 15:52:35.328436');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users (id, username, password, email, role, last_login, is_active, created_at, updated_at, full_name, phone, avatar, data_scope) VALUES (22, 'adminhanoi', '$2a$10$.C.yN74GuRSwggT1pjkH9eFpTHJqo07GDu62Ry9GSakJqIEpMBztS', 'adminhanoi@gmail.com', 'viewer', NULL, 1, '2026-01-17 07:45:01.925054', NULL, 'Admin Hà Nội', '02939393939', NULL, 'community');
INSERT INTO public.users (id, username, password, email, role, last_login, is_active, created_at, updated_at, full_name, phone, avatar, data_scope) VALUES (21, 'admindalat', '$2a$10$p6cbxFCaWuMuZzPl/AObgutft9cIlc451lHbtEypQ7lEGinrgMdTi', 'admindalat@gmail.com', 'viewer', '2026-01-17 15:13:18.276', 1, '2026-01-17 07:41:41.281966', '2026-01-17 15:52:35.292706', 'Admin Đà Lạt', '0394459503', '', 'community');
INSERT INTO public.users (id, username, password, email, role, last_login, is_active, created_at, updated_at, full_name, phone, avatar, data_scope) VALUES (1, 'admin', '$2a$10$j06wP77jF6ZWwBsf1UW85.ALYeUZi1GUOP.utcOKeKma4n43maldW', 'admin@ospsisters.vn', 'admin', '2026-01-18 00:07:43.633', 1, '2026-01-11 00:39:23.506232', '2026-01-18 00:07:43.64278', NULL, NULL, NULL, 'all');


--
-- Data for Name: vocation_journey; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.vocation_journey (id, sister_id, stage, start_date, end_date, community_id, supervisor_id, notes, location, superior, formation_director, documents) VALUES (2, 15, 'postulant', '2024-12-16', NULL, 16, NULL, NULL, 'Nhà Dòng Đà Lạt, Lâm Đồng', '16_Maria Trần Thị Mỹ Linh', '16_Maria Trần Thị Mỹ Linh', '[{"url":"http://localhost:5000/uploads/documents/1768612756259-446856523.pdf","name":"Giay chung sinh.pdf","size":235959,"uploaded_at":"2026-01-17T01:19:16.267Z"}]');
INSERT INTO public.vocation_journey (id, sister_id, stage, start_date, end_date, community_id, supervisor_id, notes, location, superior, formation_director, documents) VALUES (1, 16, 'aspirant', '2020-01-01', '2021-01-01', 15, NULL, NULL, NULL, '15_Thérèse Vũ Thị Minh Thọn', '15_Thérèse Vũ Thị Minh Thọn', '[{"url":"http://localhost:5000/uploads/documents/1768612826599-917617397.jpg","name":"d5d020e528eea2b0fbff2.jpg","size":9340,"uploaded_at":"2026-01-17T01:20:26.604Z"}]');


--
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 199, true);


--
-- Name: chat_conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.chat_conversations_id_seq', 1, true);


--
-- Name: communities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.communities_id_seq', 16, true);


--
-- Name: community_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.community_assignments_id_seq', 1, true);


--
-- Name: community_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.community_events_id_seq', 4, true);


--
-- Name: community_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.community_roles_id_seq', 20, true);


--
-- Name: departure_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.departure_records_id_seq', 1, false);


--
-- Name: education_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.education_id_seq', 2, true);


--
-- Name: education_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.education_levels_id_seq', 9, true);


--
-- Name: evaluations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.evaluations_id_seq', 1, false);


--
-- Name: health_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.health_records_id_seq', 1, false);


--
-- Name: journey_stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.journey_stages_id_seq', 6, true);


--
-- Name: missions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.missions_id_seq', 8, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.permissions_id_seq', 103, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.posts_id_seq', 1, true);


--
-- Name: sister_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sister_statuses_id_seq', 4, true);


--
-- Name: sisters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sisters_id_seq', 16, true);


--
-- Name: training_courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.training_courses_id_seq', 1, false);


--
-- Name: user_communities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_communities_id_seq', 7, true);


--
-- Name: user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_permissions_id_seq', 315, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 22, true);


--
-- Name: vocation_journey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vocation_journey_id_seq', 2, true);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: chat_conversations chat_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat_conversations
    ADD CONSTRAINT chat_conversations_pkey PRIMARY KEY (id);


--
-- Name: communities communities_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communities
    ADD CONSTRAINT communities_code_key UNIQUE (code);


--
-- Name: communities communities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communities
    ADD CONSTRAINT communities_pkey PRIMARY KEY (id);


--
-- Name: community_assignments community_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_assignments
    ADD CONSTRAINT community_assignments_pkey PRIMARY KEY (id);


--
-- Name: community_events community_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_events
    ADD CONSTRAINT community_events_pkey PRIMARY KEY (id);


--
-- Name: community_roles community_roles_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_roles
    ADD CONSTRAINT community_roles_code_key UNIQUE (code);


--
-- Name: community_roles community_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_roles
    ADD CONSTRAINT community_roles_pkey PRIMARY KEY (id);


--
-- Name: departure_records departure_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departure_records
    ADD CONSTRAINT departure_records_pkey PRIMARY KEY (id);


--
-- Name: education_levels education_levels_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.education_levels
    ADD CONSTRAINT education_levels_code_key UNIQUE (code);


--
-- Name: education_levels education_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.education_levels
    ADD CONSTRAINT education_levels_pkey PRIMARY KEY (id);


--
-- Name: education education_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.education
    ADD CONSTRAINT education_pkey PRIMARY KEY (id);


--
-- Name: evaluations evaluations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_pkey PRIMARY KEY (id);


--
-- Name: health_records health_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.health_records
    ADD CONSTRAINT health_records_pkey PRIMARY KEY (id);


--
-- Name: journey_stages journey_stages_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_stages
    ADD CONSTRAINT journey_stages_code_key UNIQUE (code);


--
-- Name: journey_stages journey_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_stages
    ADD CONSTRAINT journey_stages_pkey PRIMARY KEY (id);


--
-- Name: missions missions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_code_key UNIQUE (code);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (file_name);


--
-- Name: sister_statuses sister_statuses_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sister_statuses
    ADD CONSTRAINT sister_statuses_code_key UNIQUE (code);


--
-- Name: sister_statuses sister_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sister_statuses
    ADD CONSTRAINT sister_statuses_pkey PRIMARY KEY (id);


--
-- Name: sisters sisters_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sisters
    ADD CONSTRAINT sisters_code_key UNIQUE (code);


--
-- Name: sisters sisters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sisters
    ADD CONSTRAINT sisters_pkey PRIMARY KEY (id);


--
-- Name: training_courses training_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.training_courses
    ADD CONSTRAINT training_courses_pkey PRIMARY KEY (id);


--
-- Name: user_communities user_communities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_communities
    ADD CONSTRAINT user_communities_pkey PRIMARY KEY (id);


--
-- Name: user_communities user_communities_user_id_community_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_communities
    ADD CONSTRAINT user_communities_user_id_community_id_key UNIQUE (user_id, community_id);


--
-- Name: user_permissions user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_pkey PRIMARY KEY (id);


--
-- Name: user_permissions user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: vocation_journey vocation_journey_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocation_journey
    ADD CONSTRAINT vocation_journey_pkey PRIMARY KEY (id);


--
-- Name: idx_assignments_community; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assignments_community ON public.community_assignments USING btree (community_id);


--
-- Name: idx_assignments_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assignments_role ON public.community_assignments USING btree (role);


--
-- Name: idx_assignments_sister; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assignments_sister ON public.community_assignments USING btree (sister_id);


--
-- Name: idx_audit_table; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_table ON public.audit_logs USING btree (table_name);


--
-- Name: idx_audit_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_user ON public.audit_logs USING btree (user_id);


--
-- Name: idx_community_events_community_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_community_events_community_id ON public.community_events USING btree (community_id);


--
-- Name: idx_community_events_event_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_community_events_event_date ON public.community_events USING btree (event_date);


--
-- Name: idx_departure_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_departure_date ON public.departure_records USING btree (departure_date);


--
-- Name: idx_education_level; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_education_level ON public.education USING btree (level);


--
-- Name: idx_education_levels_active_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_education_levels_active_order ON public.education_levels USING btree (is_active, display_order, name);


--
-- Name: idx_evaluations_period; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_evaluations_period ON public.evaluations USING btree (evaluation_period);


--
-- Name: idx_health_sister; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_health_sister ON public.health_records USING btree (sister_id);


--
-- Name: idx_missions_field; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_missions_field ON public.missions USING btree (field);


--
-- Name: idx_missions_sister; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_missions_sister ON public.missions USING btree (sister_id);


--
-- Name: idx_notifications_user_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notifications_user_created_at ON public.notifications USING btree (user_id, created_at DESC);


--
-- Name: idx_notifications_user_is_read; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notifications_user_is_read ON public.notifications USING btree (user_id, is_read);


--
-- Name: idx_posts_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_posts_category ON public.posts USING btree (category);


--
-- Name: idx_posts_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_posts_deleted_at ON public.posts USING btree (deleted_at);


--
-- Name: idx_posts_is_pinned; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_posts_is_pinned ON public.posts USING btree (is_pinned);


--
-- Name: idx_posts_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_posts_status ON public.posts USING btree (status);


--
-- Name: idx_sisters_dob; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sisters_dob ON public.sisters USING btree (date_of_birth);


--
-- Name: idx_sisters_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sisters_status ON public.sisters USING btree (status);


--
-- Name: idx_training_courses_sister; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_training_courses_sister ON public.training_courses USING btree (sister_id);


--
-- Name: idx_user_communities_community_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_communities_community_id ON public.user_communities USING btree (community_id);


--
-- Name: idx_user_communities_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_communities_user_id ON public.user_communities USING btree (user_id);


--
-- Name: idx_users_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_active ON public.users USING btree (is_active);


--
-- Name: idx_users_data_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_data_scope ON public.users USING btree (data_scope);


--
-- Name: idx_users_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_role ON public.users USING btree (role);


--
-- Name: idx_vocation_sister; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_vocation_sister ON public.vocation_journey USING btree (sister_id);


--
-- Name: idx_vocation_stage; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_vocation_stage ON public.vocation_journey USING btree (stage);


--
-- Name: communities communities_updated_at_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER communities_updated_at_trigger BEFORE UPDATE ON public.communities FOR EACH ROW EXECUTE FUNCTION public.update_communities_updated_at();


--
-- Name: community_roles community_roles_updated_at_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER community_roles_updated_at_trigger BEFORE UPDATE ON public.community_roles FOR EACH ROW EXECUTE FUNCTION public.update_community_roles_updated_at();


--
-- Name: evaluations evaluations_updated_at_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER evaluations_updated_at_trigger BEFORE UPDATE ON public.evaluations FOR EACH ROW EXECUTE FUNCTION public.update_evaluations_updated_at();


--
-- Name: health_records health_records_updated_at_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER health_records_updated_at_trigger BEFORE UPDATE ON public.health_records FOR EACH ROW EXECUTE FUNCTION public.update_health_records_updated_at();


--
-- Name: sisters sisters_updated_at_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER sisters_updated_at_trigger BEFORE UPDATE ON public.sisters FOR EACH ROW EXECUTE FUNCTION public.update_sisters_updated_at();


--
-- Name: users users_updated_at_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER users_updated_at_trigger BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_users_updated_at();


--
-- Name: chat_conversations chat_conversations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat_conversations
    ADD CONSTRAINT chat_conversations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: community_events community_events_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_events
    ADD CONSTRAINT community_events_community_id_fkey FOREIGN KEY (community_id) REFERENCES public.communities(id) ON DELETE CASCADE;


--
-- Name: community_assignments fk_assignments_community; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_assignments
    ADD CONSTRAINT fk_assignments_community FOREIGN KEY (community_id) REFERENCES public.communities(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: community_assignments fk_assignments_sister; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_assignments
    ADD CONSTRAINT fk_assignments_sister FOREIGN KEY (sister_id) REFERENCES public.sisters(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: audit_logs fk_audit_logs_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT fk_audit_logs_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: departure_records fk_departure_sister; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departure_records
    ADD CONSTRAINT fk_departure_sister FOREIGN KEY (sister_id) REFERENCES public.sisters(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: education fk_education_sister; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.education
    ADD CONSTRAINT fk_education_sister FOREIGN KEY (sister_id) REFERENCES public.sisters(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: evaluations fk_evaluations_evaluator; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT fk_evaluations_evaluator FOREIGN KEY (evaluator_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: evaluations fk_evaluations_sister; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT fk_evaluations_sister FOREIGN KEY (sister_id) REFERENCES public.sisters(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: health_records fk_health_records_sister; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.health_records
    ADD CONSTRAINT fk_health_records_sister FOREIGN KEY (sister_id) REFERENCES public.sisters(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: missions fk_missions_sister; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT fk_missions_sister FOREIGN KEY (sister_id) REFERENCES public.sisters(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sisters fk_sisters_created_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sisters
    ADD CONSTRAINT fk_sisters_created_by FOREIGN KEY (created_by) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sisters fk_sisters_current_community; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sisters
    ADD CONSTRAINT fk_sisters_current_community FOREIGN KEY (current_community_id) REFERENCES public.communities(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: training_courses fk_training_courses_sister; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.training_courses
    ADD CONSTRAINT fk_training_courses_sister FOREIGN KEY (sister_id) REFERENCES public.sisters(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: vocation_journey fk_vocation_journey_community; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocation_journey
    ADD CONSTRAINT fk_vocation_journey_community FOREIGN KEY (community_id) REFERENCES public.communities(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: vocation_journey fk_vocation_journey_sister; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocation_journey
    ADD CONSTRAINT fk_vocation_journey_sister FOREIGN KEY (sister_id) REFERENCES public.sisters(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: vocation_journey fk_vocation_journey_supervisor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocation_journey
    ADD CONSTRAINT fk_vocation_journey_supervisor FOREIGN KEY (supervisor_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: posts posts_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: user_communities user_communities_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_communities
    ADD CONSTRAINT user_communities_community_id_fkey FOREIGN KEY (community_id) REFERENCES public.communities(id) ON DELETE CASCADE;


--
-- Name: user_communities user_communities_granted_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_communities
    ADD CONSTRAINT user_communities_granted_by_fkey FOREIGN KEY (granted_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: user_communities user_communities_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_communities
    ADD CONSTRAINT user_communities_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_permissions user_permissions_granted_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_granted_by_fkey FOREIGN KEY (granted_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: user_permissions user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: user_permissions user_permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

-- end garbage removed

