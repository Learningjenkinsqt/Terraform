### Multi stage Docker file for StudentCoursesRestAPI
FROM alpine/git AS vcs
RUN cd / && git clone https://github.com/DevProjectsForDevOps/StudentCoursesRestAPI.git && \
    pwd && ls /StudentCoursesRestAPI

FROM python:3.8.3-alpine AS Builder
LABEL author="Prakash Reddy" organization="qt" project="learning"
COPY --from=vcs /StudentCoursesRestAPI /StudentCoursesRestAPI
ARG DIRECTORY=StudentCourses
RUN cd / StudentCoursesRestAPI cp requirements.txt /StudentCourses
ADD . ${DIRECTORY}
EXPOSE 8080
WORKDIR StudentCoursesRestAPI
RUN pip install --upgrade pip 
RUN pip install -r requirements.txt
ENTRYPOINT ["python", "app.py"]



FROM python:3.8.3-alpine
LABEL author="Prakash Reddy" organization="qt" project="StudentCoursesRestAPI"
RUN apk add --update && apk add git
RUN git clone https://github.com/DevProjectsForDevOps/StudentCoursesRestAPI.git && \
    cd StudentCoursesRestAPI && mkdir StudentCourses
ARG DIRECTORY=StudentCourses
RUN cd / StudentCoursesRestAPI cp requirements.txt /StudentCourses
ADD . ${DIRECTORY}
EXPOSE 8080
WORKDIR StudentCoursesRestAPI
RUN pip install --upgrade pip 
RUN pip install -r requirements.txt
ENTRYPOINT ["python", "app.py"]