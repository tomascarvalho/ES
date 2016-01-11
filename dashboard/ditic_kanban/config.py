#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# By Pedro Vapi @2015
# This python file aim is to provide all configuration necessary for usiDITICConfigng this packageI
#


class DITICConfig:
    """
    This class contains all configuration for this server
    """
    def __init__(self):
        """
        This class contains those special variables.
        All configurations for this server should be done here!
        More important variables:

            # Mapping email to user alias
            self.email_to_user = {
                'email': 'user',
                ...
            }

            # Map user alias to its Kanban limits
            self.user_limits = {
                'user': {
                    'status': value,
                    ...
                }
                ...
            }

            # System configurations (server address, username, pwd, ...)
            self.system = {
                'variable': 'value',
                ...
            }

        :return: None
        """
        self.email_to_user = {
            'apardal@student.dei.uc.pt': 'Ana Pardal',
            'misimoes@student.dei.uc.pt': 'Ines Simoes',
            'jpolivei@student.dei.uc.pt': 'João Oliveira',
            'mscerv@student.dei.uc.pt': 'Mariana Cerveira',
            'ritaa@student.dei.uc.pt': 'Rita Almeida',
            'tmdcc@student.dei.uc.pt': 'Tomas Carvalho',
            'nocomment@uc.pt': 'noComment',
            'vapi@uc.pt': 'Vapi',
            'asantos@uc.pt': 'Alex',
            'cpratas@uc.pt': 'Carlos',
            'testes_aceitacao@uc.pt': 'testes_aceitacao',
        }
        self.email_limits = {

            'apardal@student.dei.uc.pt': {
                'new': 7,
                'open': 3,
                'rejected': 7,
            },
       
            'misimoes@student.dei.uc.pt': {
                'new': 5,
                'open': 3,
                'rejected': 5,
               
            },
            'jpolivei@student.dei.uc.pt': {
                'new': 5,
                'open': 3,
                'rejected': 5,
                
            },
            'mscerv@student.dei.uc.pt': {
                'new': 7,
                'open': 1,
                'rejected': 7,
               
            },
            'ritaa@student.dei.uc.pt': {
                'new': 14,
                'open': 2,
                'rejected': 14,
                
            },
            'tmdcc@student.dei.uc.pt': {
                'new': 7,
                'open': 3,
                'rejected': 7,
                
            },
            'nocomment@uc.pt': {
                'new': 4,
                'open': 1,
                'rejected': 14,
               
            },
            'vapi@uc.pt': {
                'new': 7,
                'open': 1,
                'rejected': 7,
                
            },
            'asantos@uc.pt': {
                'new': 14,
                'open': 2,
                'rejected': 14,
                
            },
            'cpratas@uc.pt': {
                'new': 5,
                'open': 3,
                'rejected': 5,
                
            }, 
            'testes_aceitacao@uc.pt': {
                'new': 5,
                'open': 3,
                'rejected': 5,
            },   
        }
        self.list_status = [
            'new',
            'open',
            'stalled',
            'rejected',
            'resolved',
            'deleted',
            'archived'
        ]
        self.system = {
            'working_dir': '/home/rita/env/dashboard/ditic_kanban',
            'summary_file': 'summary',
            'server': 'localhost/rt',
            'username': 'root',
            'password': 'rtrita',
            'statistics_file': 'statistics',
}

    def get_email_to_user(self):
        return self.email_to_user

    def get_system(self):
        return self.system

    def get_user_from_email(self, email):
        """
        Returns the user based on its email address. This information is based on the config file

        :param email:
        :return:
        """
        return self.email_to_user[email]

    def get_email_from_user(self, user):
        """
        Returns the email based on user alias

        :param user: user alias
        :return: email address. If no alias found, return ''
        """
        for email in self.email_to_user:
            if user == self.email_to_user[email]:
                return email
        return ''

    def get_users_list(self):
        """
        Returns the list of users (not it's emails!)

        :return:
        """
        return self.email_to_user.values()

    def get_email_limits(self, email, status=''):
        """
        Get the email Kanban limits

        :return: If status is provided, then return that status limits (int).
                 If no status is required, then return the dictionary with all limits
        """
        if status:
            if email not in self.email_limits.keys() or status not in self.email_limits[email]:
                return 0
            return self.email_limits[email][status]
        else:
            if email not in self.email_to_user.keys():
                return {}
            return self.email_limits[email]

    def get_list_status(self):
        return self.list_status

    def check_if_user_exist(self, user):
        """
        Check if the user (not it's email) exist.
        The user is defined in the config file. You may add there more users

        :param user:
        :return:
        """
        return user in self.email_to_user.values()

    def check_if_email_exist(self, email):
        """
        Check if the email exist.
        The email is defined in the config file. You may add there more emails

        :param email:
        :return:
        """
        return email in self.email_to_user.keys()
