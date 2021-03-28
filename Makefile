# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lpaulo-m <lpaulo-m@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/26 16:25:08 by lpaulo-m          #+#    #+#              #
#    Updated: 2021/03/28 03:06:36 by lpaulo-m         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = ft_libbmp.a

CC = gcc
CC_FLAGS = -Wall -Wextra -Werror
CC_DEBUG_FLAGS = -g

EXTERNAL_LIBS = -lm

MAKE_EXTERNAL = make -C
SAFE_MAKEDIR = mkdir -p
ARCHIVE_AND_INDEX = ar -rcs
COPY = cp

REMOVE = /bin/rm -f
REMOVE_RECURSIVE = /bin/rm -rf

OBJECTS_PATH = ./objects
SOURCES_PATH = ./sources
INCLUDES_PATH = ./includes
LIBS_PATH = ./libs
ARCHIVES_PATH = ./archives
EXAMPLES_PATH = ./examples

HEADER_FILE = weekendrt.h
HEADER = $(addprefix $(INCLUDES_PATH)/,$(HEADER_FILE))

SOURCE_FILES = vector_3d.c color.c \
	ray.c hittable.c sphere.c camera.c \
	ray_tracer.c errors.c
SOURCES = $(addprefix $(SOURCES_PATH)/,$(SOURCE_FILES))

OBJECTS = $(addprefix $(OBJECTS_PATH)/,$(subst .c,.o,$(SOURCE_FILES)))

LIBFT = libft.a
LIBFT_PATH = $(LIBS_PATH)/libft
LIBFT_ARCHIVE = $(ARCHIVES_PATH)/$(LIBFT)

FT_LIBBMP = ft_libbmp.a
FT_LIBBMP_PATH = $(LIBS_PATH)/ft_libbmp
FT_LIBBMP_ARCHIVE = $(ARCHIVES_PATH)/$(FT_LIBBMP)

EXAMPLE_MAIN = $(EXAMPLES_PATH)/example.c
BLUE_GRADIENT_MAIN = $(EXAMPLES_PATH)/blue_gradient.c
IMAGE_NAME = hello.bmp
EXECUTE_EXAMPLE = ./a.out $(IMAGE_NAME)
OPEN_IMAGE = ffplay
EXAMPLE_GARBAGE = a.out a.out.dSYM $(IMAGE_NAME)

all: $(NAME)

$(NAME): build_libft build_ft_libbmp $(OBJECTS) $(HEADER)
	$(ARCHIVE_AND_INDEX) $(NAME) $(OBJECTS) 

$(OBJECTS_PATH)/%.o: $(SOURCES_PATH)/%.c $(HEADER)
	$(SAFE_MAKEDIR) $(OBJECTS_PATH)
	$(CC) $(CC_FLAGS) -I $(INCLUDES_PATH) -o $@ -c $< $(EXTERNAL_LIBS)

build_example: $(NAME)
	$(CC) $(CC_DEBUG_FLAGS) -I $(INCLUDES_PATH) $(EXAMPLE_MAIN) $(NAME) $(FT_LIBBMP_ARCHIVE) $(EXTERNAL_LIBS)

example: build_example
	$(EXECUTE_EXAMPLE)
	$(OPEN_IMAGE) $(IMAGE_NAME)

build_libft:
	$(MAKE_EXTERNAL) $(LIBFT_PATH)
	$(SAFE_MAKEDIR) $(ARCHIVES_PATH)
	$(COPY) $(LIBFT_PATH)/$(LIBFT) $(LIBFT_ARCHIVE)

build_ft_libbmp:
	$(MAKE_EXTERNAL) $(FT_LIBBMP_PATH)
	$(SAFE_MAKEDIR) $(ARCHIVES_PATH)
	$(COPY) $(FT_LIBBMP_PATH)/$(FT_LIBBMP) $(FT_LIBBMP_ARCHIVE)

clean:
	$(REMOVE) $(OBJECTS)

fclean: clean ft_libbmp_clean
	$(REMOVE) $(NAME)

example_clean: fclean
	$(REMOVE_RECURSIVE) $(EXAMPLE_GARBAGE)

libft_clean:
	$(MAKE_EXTERNAL) $(LIBFT_PATH) fclean

ft_libbmp_clean:
	$(MAKE_EXTERNAL) $(FT_LIBBMP_PATH) fclean

re: fclean all

norm:
	norminette $(INCLUDES_PATH)
	@echo ----------------------
	norminette $(SOURCES_PATH)

git:
	git add -A
	git commit -m "update"
	git push

gitm:
	git add -A
	git commit -m $m
	git push

.PHONY: all build_example example build_libft build_ft_libbmp \
		clean fclean example_clean ft_libbmp_clean \
		re norm git gitm
