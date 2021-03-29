/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rtrandom.h                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lpaulo-m <lpaulo-m@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/28 14:51:24 by lpaulo-m          #+#    #+#             */
/*   Updated: 2021/03/29 03:40:23 by lpaulo-m         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef RTRANDOM_H
# define RTRANDOM_H

# include <vector_3d.h>

double			random_double(void);
double			random_from(double min, double max);
double			rp(void);
double			rr(void);
double			canonical_random(void);

t_vector_3d		random_vector(void);
t_vector_3d		random_vector_in(double min, double max);
t_point_3d		random_point_in_unit_sphere(void);

#endif
